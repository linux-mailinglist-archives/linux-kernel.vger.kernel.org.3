Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A079A54CC16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiFOPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiFOPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:02:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368138D83
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:02:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so11507546pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeL22Tj/KeUMdZCI0ao7YL9Y2reNjsNfv6khr7OlAV0=;
        b=agBC36OdDpu/KWpn2HxuUTcTbnGLZdB5qmPA4H+tXrv2gbncSrIisgsBApDNkNn1V7
         kNaHxNFhFlGWY+gNJuaeVmjUBwAjNNbBWgDGYq+VF4Z72pheQ8bx8P6AFm75Ut+rM54n
         7G8otbD7O2W60rMXvnr4dI4ZnIE25K58zOBnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeL22Tj/KeUMdZCI0ao7YL9Y2reNjsNfv6khr7OlAV0=;
        b=x6bFHm6ldrXarGeBkMd4UaTmGASMx0BD9I44wVFCHAs2aDnEBE4RVeZLBU+jaDKrpP
         HPt9B9RLt4pujLCKFmEAPnk4dFP88XgOFmsX28MbJ4Pr5kxX4Z2e28+2UvuiyLGxDDxS
         F3gDMUaQf1p/JpXdDsHoFhZtZpzJOGdlLqQgGvA7XDAptUR7cWRcQfUVXBz7lwdXc9CG
         xR7c9E4pZQyMC0AyNXzCiR/vcqtbUooswucPmwN4VZBSKevi0h6fHcBN6ubwDll8J6TK
         8j+gUzjR8X8qtquroZysV7dyq7rgYspxPsFfp+xViNr8vzRMHxHE1dK77HeUwsC9TebL
         9y4w==
X-Gm-Message-State: AJIora8tk4xSk+YalotC2tTM03K1wHrHUCWkF30ztALKmdy3FMGigINr
        AmZ5541LnOIw1PPtXqV4vWLSQA==
X-Google-Smtp-Source: AGRyM1td36xSGFQnJkvHTUcezMu4K0BcUeS9f+l4kq5FyN7wehDQYHEwf2WNZGO2XmSX5IIp8mYoBA==
X-Received: by 2002:a17:902:f149:b0:167:8569:ec00 with SMTP id d9-20020a170902f14900b001678569ec00mr274940plb.8.1655305320871;
        Wed, 15 Jun 2022 08:02:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b001e0d4169365sm1921226pji.17.2022.06.15.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:02:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     avagin@gmail.com, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, brauner@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, ebiederm@xmission.com,
        linux-mm@kvack.org, fweimer@redhat.com
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on vfork+exec
Date:   Wed, 15 Jun 2022 08:01:48 -0700
Message-Id: <165530530544.261757.10728167525988459977.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613060723.197407-1-avagin@gmail.com>
References: <20220613060723.197407-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 23:07:22 -0700, Andrei Vagin wrote:
> Right now, a new process can't be forked in another time namespace
> if it shares mm with its parent. It is prohibited, because each time
> namespace has its own vvar page that is mapped into a process address
> space.
> 
> When a process calls exec, it gets a new mm and so it could be "legal"
> to switch time namespace in that case. This was not implemented and
> now if we want to do this, we need to add another clone flag to not
> break backward compatibility.
> 
> [...]

Applied to for-next/execve, thanks!

[1/2] fs/exec: allow to unshare a time namespace on vfork+exec
      https://git.kernel.org/kees/c/133e2d3e81de
[2/2] testing/timens: add a test for vfork+exit
      https://git.kernel.org/kees/c/6342140db660

-- 
Kees Cook

