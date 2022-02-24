Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1564C215B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBXBvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiBXBvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:51:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B7159293;
        Wed, 23 Feb 2022 17:51:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id l19so563107pfu.2;
        Wed, 23 Feb 2022 17:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RhKhAkTTrkMeO2LTTiP23E3IDSrksBY5pBg7ODoVhdQ=;
        b=GQqAtyFgniyh0PvnLWGmDOmG60ubr9j4MKOjIrQrxaDRQj37QD4Rtzaea0Ry3CEs3r
         eClV5OXDOg8b3YM1sZt+Xu3676vAGdH773d6zFYm2ti4Nk3qP9pvfhMJTJGbXjVt0u5y
         +UDrMgYKKXj/AVrQ5eT4k7bWrmyqQpXLDg9XGU5HpWnnlcnoBaVauB7qnbYJyQwhrRX/
         vwLcnvnezSxcjxcGnybSjWlcBZXTBECm9/n90jNZYXdTPl+gLfw5hrlSgh3gq5NuloUp
         m5r84yD9t9ic9Gop/RPGY3VbHLZZZgUzOxTs03xwU0+uYS749YyLt9MWSyZokA23JdRJ
         CQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RhKhAkTTrkMeO2LTTiP23E3IDSrksBY5pBg7ODoVhdQ=;
        b=ncFTVxMbaKZ+xPKjxEetx79Djmi3THfa9RD5yTceUveBH2pIgm7xqHQK54YvVLM+6z
         aXxQsS5ud0aflcnBl4qpT1XDpJKInQ075ENavuoIqPupogBe6lN1iTPiMGn2FK3V9tx3
         7CGgfYfDZcOZCwadhbHwEBIYVf2nqbk4kGHZyZQ/JggznNkOp9blBWc3rKlyYeTrJnnD
         l6bSGZ+wsgVPX02eTZ+viXCNHTLtOq9v9Zh3VPZpUWc+b8unz8YodHlEwyKq5qk+wo7Y
         A7iBPeSMfLiDy9+SYsZwuruykv6icLgVKLR+2iF2IZiBISdb1n1+/K3PNnygDPHuySe8
         A5YA==
X-Gm-Message-State: AOAM530TNScN2VsAHsKkZreL9XmYIGmH8AS/DN0iGe6afEnH4qt6URRs
        V/S6nXtZt/zQ1hviNN4r8lsUaXTTiE0ufg==
X-Google-Smtp-Source: ABdhPJx51vfxbOZNXNBHmmp/JoXM+3xQyq1uApYDSP0c1CdAZvWtpLWVREhwI0LPOaY9K1Fo15lt8w==
X-Received: by 2002:a63:d64d:0:b0:374:6edc:989c with SMTP id d13-20020a63d64d000000b003746edc989cmr493333pgj.434.1645667466973;
        Wed, 23 Feb 2022 17:51:06 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id g1sm808146pfu.32.2022.02.23.17.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 17:51:06 -0800 (PST)
Message-ID: <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
Date:   Thu, 24 Feb 2022 09:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
 <YhapCurbiI21WYmm@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <YhapCurbiI21WYmm@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/24 5:37 上午, Tejun Heo wrote:
> Hello,
> 
>>> We just want to provide the flexibility for the user to open/close a policy
>>> per device. If we need to the policy on a device, we needn't to waste cpu
>> sorry, it should be "If we don't need the policy on a device" ;)
> 
> Yeah, that's what modularization does but why does it need a separate user
> interface for loading? Everything else inits on insmod and exits on rmmod
> and autoloading has been delegated to udev a very long time ago. The
> interface you added for loading module doesn't make sense to me.
> 

The initial version of this patchset has two targets：
(1) Add a sysfs interface to open/close the policy per device. Then we needn't
    waste cpu cycles and memory if the device doesn't need the policy.
(2) Make the policies modular, then it easy to maintain the code of policy in
    production environment as we only need to close the policy and replace the
    .ko file.

The loading module when open policy in sysfs interface is just to avoid modprobe
manually. There is similar operation when switch io scheduler.

And as Christoph suggested, the modularization has been get rid of in next version.

Thanks
Jianchao
