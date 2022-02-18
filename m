Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7654BB48C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiBRIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:46:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiBRIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:46:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191092B31BE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:15 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so3232832ljh.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t9b9rg6sUnB//OWPm/5/rLHFY80usrHJZeh5EGJPtRQ=;
        b=HKAiT1PDXlsfJccd3bg55wPer6PXUHwnuD3nl4MzIj5IxpFIwAg6B2UJKCFMxsFvXn
         mo/3HiQZTPLm30wfCB9vOKNkWdRJmy6z56eicpfOW1tzrpJ9wjziBCFLSlbYDQVUcyw8
         tJUKCIU4G9ZjzOjWu7qyhUUGZberMMDhG9Jc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t9b9rg6sUnB//OWPm/5/rLHFY80usrHJZeh5EGJPtRQ=;
        b=5uWimNMRp37MR4OaH8TNOW5+DEDa4Fsp2mQr5ZAlbE/w0gHAzPrz/lg7w/r6fZLuHe
         ZHfniJN7/N48jMGVV3ehYyn4lOZ7F+VGLKICd3DtK816t6i7PxCmfw0BACktIOrFuWkm
         PpCY9lR1/9OWKlg8BCADZDVOkCboRnQdr5XtVmnJgHQ/mXvg2ucItlhkEAOC/a2KlCKq
         aZbhTSDC8YZ9h6DL7B2pHA7h31vFvanA8LRgajfWYSvS8IWCFOpMmmphj5YTEKYfSc/n
         Q/3ypZxCx/roT6bbqUW26Mg3vqSFr52bAloIRMWjuQghAtwGUBNlp4D0FPyG5qGVP+8p
         azmQ==
X-Gm-Message-State: AOAM5321/NLa+F+eg+grKAreKZYL+I7DpIBhljZxEVGdISwyLdg+c+iT
        3RfdrKW13qBa1ifrz9GdxuU6ow==
X-Google-Smtp-Source: ABdhPJyB3xaMv90jm/lGgbF0xf9/ttZd+yigc3a5+e2Sy+pQoHQ48LP4HBy5igXyhhSsP8IO/Fj9mQ==
X-Received: by 2002:a2e:bf27:0:b0:244:beb1:72b4 with SMTP id c39-20020a2ebf27000000b00244beb172b4mr5032621ljr.109.1645173973413;
        Fri, 18 Feb 2022 00:46:13 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s10sm188953lfb.248.2022.02.18.00.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:46:12 -0800 (PST)
Message-ID: <1ac1e478-8f31-da78-0df7-d34305544aa6@rasmusvillemoes.dk>
Date:   Fri, 18 Feb 2022 09:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: PROBLEM: kasprintf WARN() seen during AMD XGBE debugfs creation
 on renaming race
Content-Language: en-US
To:     "Pighin, Anthony (Nokia - CA/Ottawa)" <anthony.pighin@nokia.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BN0PR08MB6951BF9664D8BB97AB4C753183369@BN0PR08MB6951.namprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <BN0PR08MB6951BF9664D8BB97AB4C753183369@BN0PR08MB6951.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 15.39, Pighin, Anthony (Nokia - CA/Ottawa) wrote:
> PROBLEM: Commit 8e2a2bfdb86ecb2421e3dd18d0fbbb42f2d943ad is being
> triggered during debugfs entry creation in
> ./drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
> 
>  
> 
> Seen in 5.4.153, 5.15.22, and 5.17-rc3 (ie. this bug is still present).
> 


Well, it's not really 8e2a2bfdb that is buggy, but the caller of
kasprintf() that doesn't prevent a %s argument from changing midway
through the call. In fact this simply shows that 8e2a2bfdb was justified.

In this case, since IFNAMSIZ is just 16, it would probably be simplest
and easiest just to avoid kasprintf() and use a small stack buffer

- char *buf;
+ char buf[32];

- buf = kasprintf(GFP_KERNEL, "amd-xgbe-%s", pdata->netdev->name);
- if (!buf)
-   return;
+ snprintf(buf, sizeof(buf), "amd-xgbe-%s", pdata->netdev->name);

- kfree(buf);

It's still possible to get garbage in the output (a mix of the old and
new name), of course.

But IIRC correctly, updating the netdev->name is done carefully in a way
that there's always a nul-terminator, so snprintf() should not
accidentally walk off the end of netdev->name [look at string() in
vsprintf.c, it has been carefully rewritten to not walk the string
twice]. And if not, there's really nothing snprintf() or kasprintf()
could do about passing a racy netdev->name .

And while in there, the use of kasprintf() in xgbe_common_read() might
as well be avoided, a 16 byte stack buffer is plenty, and removes the
need for the 'if (!buf)' check and multiple kfree(buf) on the various
return paths.

Rasmus
