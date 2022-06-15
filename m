Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13BF54D3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbiFOVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbiFOVaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:30:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140AA562CF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:30:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so12547993pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=gj8zUzDSKIR2PtxM/UZSWlhmSPN0w/aiFm/JeXggx3M=;
        b=weZbBbUSK+6ocvp/YzFFHERgkjbmlZTADEbrz1GAxTVzxSC0U49PCdEOH6oQqf7vPz
         nnHfHtXXNUDmyBx+yThH5CR4nybHplJAsV0CqFWV/6gMaSaL4qy+qeUGgvujL9s2yaWK
         4F6Uc981Rii/LasC0DFpKRLwmglkSD+vTqFfpdHMk+CQ7Lth+H7DzmI4llkqjDALQutO
         g/FQ6ChGc1D71hkvXTzI8me3/McOdQExjqL6ujqiWcUPZDRGGn4hoZO8oXDvSXwEU3L2
         6iKQkcF2xrS7xqRwL/WHHo3p0pIG/NlpMPnXukfcAG2XpyKd61H/Pi8VXAduwxBymBg5
         OGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=gj8zUzDSKIR2PtxM/UZSWlhmSPN0w/aiFm/JeXggx3M=;
        b=JLTUi2pJO3E3wIt67uVhztWHKNkYYxEazMhuSKWdtEdpVwjevawMjNTEOqn6AEm1Px
         Jrnp9mc93a3HCZTOpGf+5iF+HlEytU6UheyM7G8hm3uhM+reDctusmZvnknxPBHPh3CP
         mqyXtOEDKf1W9bMvWGGTUco2Fw5Tdz0Q6NKCZqMeZUq51t8JPFx+OuqiV5oE8S2a4UcK
         SUQCnL0OpbrL3XOL/mSJK9LIlpTZOJWwisqV2TuDtsU/XwJi3nQsT7slwqUlko/LAoGF
         1DHhnNyuZEOGPgigjOlxqO1C/7Y8CfL/tK29Y+ivBjQhZGLh9Isp87o/IKC9LxrLvsZu
         rKAg==
X-Gm-Message-State: AJIora85Kij7kpB50aJ27e1yoDu21MeX7ySCfdYYuc5GSbxJERDq65zB
        phkBsN3cqnsaksPvswwPPuCH9tnwFe4aQQ==
X-Google-Smtp-Source: AGRyM1v0IMTmN8GOvRn4uNva8PDhOEex3sAELCaW2rWI3VxM7LPVY+4GwPMUV/TKADCMwWmQqaUbnA==
X-Received: by 2002:a63:194c:0:b0:408:a9d1:400c with SMTP id 12-20020a63194c000000b00408a9d1400cmr1544266pgz.559.1655328633528;
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id js12-20020a17090b148c00b001e86be34c98sm2313057pjb.13.2022.06.15.14.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:30:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     liubo03@inspur.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220615081816.4342-1-liubo03@inspur.com>
References: <20220615081816.4342-1-liubo03@inspur.com>
Subject: Re: [PATCH] block: Directly use ida_alloc()/free()
Message-Id: <165532863283.858456.2064903368423247771.b4-ty@kernel.dk>
Date:   Wed, 15 Jun 2022 15:30:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 04:18:16 -0400, Bo Liu wrote:
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> 

Applied, thanks!

[1/1] block: Directly use ida_alloc()/free()
      commit: c13794dbe936a62a9b509ece1423a59287b9c80f

Best regards,
-- 
Jens Axboe


