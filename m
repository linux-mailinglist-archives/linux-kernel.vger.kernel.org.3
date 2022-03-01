Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C834C8509
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiCAH0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiCAH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:26:40 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472647B56F;
        Mon, 28 Feb 2022 23:25:50 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z16so13426920pfh.3;
        Mon, 28 Feb 2022 23:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xwPzYLmL8tsAcjKkLlXm2q5GxjDpfr4uBY/mxxN6f0=;
        b=p0hUnlIqn4nB+9QAy6YtbzwVtFaaRd3iLy5CeGRJu5XFinQuo46QvcMxMAvlZ01ztU
         +mh6iQ/P7DJY+bwlRLg36NWkpIyniBCQb0arpYppSI5gzAAuBH1Io0jqnjiBD79g4BqT
         Koo6G2VmqJP+0hONu2wOf6bENkDdMbyj4bwGiBlIstAqz661ZuLR1ELpxudC5PNdg0nM
         r37aPSH1Sq8Y1mm+MW4EltUhHuUWbCddplrmHG0WGMmFSVdnLDwd5ZYnmf3lVwACKRQv
         Ly7j+WZVz6RFqrkCEB5o1hiKiSkS57kzfkMfDyfvxAaLw6JY/oor4ije/sbmdKZiwsdp
         avZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xwPzYLmL8tsAcjKkLlXm2q5GxjDpfr4uBY/mxxN6f0=;
        b=HQoxAQGY0K1DeezCK3veYbJPxPX+W2hxKWB0gG1d5pIYGoCIZ5NmndiatQDZ3WWTb9
         Is3KpsAcCNXIAN8t+KnOVPOWNvmuQAjyW1GD4nOTZz92tC/8c+F5PPDR/v3+DlKxgtx1
         9yk3Iw7XUdfGQMQS55sFZUmIl76RW+qfabJZy5qeJmlPDt7No/s0dDiu6XkX8PRhv7ME
         6FUQocVq54VFVwobwvadto9xZ9uO7hLTHdkQEwxSjcxEbMVwHa1KPWHWY+DVvuSPKXIP
         ZXjVo+6Tb7i4Ai9JY5Ze61QLz9qVTFYG16a6FGcFTO1oR40dUpuWUUGDvkAu7l0UmcR9
         KFbQ==
X-Gm-Message-State: AOAM530mq7SHM9brWxAF+xuiSNNpX8KnGrOU8l6nbo6DI6wTtzs9NKZW
        y8y1C8vMfQCfDmARgRjsnKI=
X-Google-Smtp-Source: ABdhPJxk2kkLGOShKr8fWcTWXMBEiU8Tp/GN26wOurQxDFduiq9JdkHrSPrhG04imVVDVCPRuqu8Bw==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:786c:cce3 with SMTP id g4-20020a056a001a0400b004e1786ccce3mr25912833pfv.81.1646119549671;
        Mon, 28 Feb 2022 23:25:49 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c174:264:5e49:f2cb])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm636489pfw.188.2022.02.28.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:25:48 -0800 (PST)
Date:   Mon, 28 Feb 2022 23:25:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: da9063 - Use devm_delayed_work_autocancel()
Message-ID: <Yh3KegzMC+JuUOdn@google.com>
References: <a76ac3f4c7aee205395b89b5b3f587e30a48df96.1645205312.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76ac3f4c7aee205395b89b5b3f587e30a48df96.1645205312.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 06:29:13PM +0100, Christophe JAILLET wrote:
> Use devm_delayed_work_autocancel() instead of hand-writing it.
> This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
