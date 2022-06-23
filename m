Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031955771F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFWJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiFWJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:50:16 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D1A1A9;
        Thu, 23 Jun 2022 02:50:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id o9so18486027edt.12;
        Thu, 23 Jun 2022 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8ghPZJULwgcvOIIuUmECv/qBnpG0RYGHrLQOgEEsZlY=;
        b=yCABGNQ98gYPKbN/tnS8J67vXZLM8V6CDvIlMqHsP0JGH446nBVk7+GX4jW039INJy
         oycII5tfwgiOSBcKA5QiCBMdE2zSlHAHBQG8lOp9sH5FWIqyIoJbmrav0EeTReb0MFCc
         azKLdIMqhqlS4gfGHP2Xif0AGRIaZ26zsdH3H25deoLxBepkBxuUFmLCwAAjmr7RcYyV
         ZWxCYYUDLPYssyCOARvuQSneLqcUe80vmjhcl28EOW1Q4btEFL+SyTII/nT8bobZLcr/
         dRVsgQCW40w/lXeWDFXPWMxiN3ujzZNqkSUXsscsoPbgC1WCemMJ/tfyAOw5E3lRADXv
         tDnw==
X-Gm-Message-State: AJIora+yIf1lcSQuZAAGX6fpM1qRkAsPsQRxd12fycWWW43lDg9m47al
        buIGSUMFMgXIKpJI9liyrdE=
X-Google-Smtp-Source: AGRyM1sTEVx70huHg0D8xHYZRwmVHfDV9VCKFayHlo5RYukxq88kGOtl4SMAKvx8iDot134JeHq5fw==
X-Received: by 2002:a05:6402:370c:b0:435:cb14:9aa8 with SMTP id ek12-20020a056402370c00b00435cb149aa8mr3234894edb.35.1655977813766;
        Thu, 23 Jun 2022 02:50:13 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id t24-20020a056402021800b004356a647d08sm12951296edv.94.2022.06.23.02.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 02:50:13 -0700 (PDT)
Message-ID: <217838e7-f840-a957-74cc-d878ae0b1820@kernel.org>
Date:   Thu, 23 Jun 2022 11:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] kbuild, link-vmlinux: Don't delete output files with make
 -i
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <20220623083105.26354-1-jslaby@suse.cz>
 <CAK7LNARaB8-4mm4sZwH2DxGE=GAhS8HiF+-uT9suiHYHe8PgwQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNARaB8-4mm4sZwH2DxGE=GAhS8HiF+-uT9suiHYHe8PgwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 06. 22, 11:45, Masahiro Yamada wrote:
> On Thu, Jun 23, 2022 at 5:31 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> From: Andi Kleen <andi@firstfloor.org>
>>
>> make -i is useful to see output files which normally get deleted on an
>> error.  Make this work with link-vmlinux.sh too. Don't delete the output
>> files on error when make -i is used.
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: linux-kbuild@vger.kernel.org
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
> 
> 
> 
> I am afraid you missed this commit:
> 
> 
> 
> commit 51eb95e2da41802454f48b9afeb4d96a77295035
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Tue May 4 20:35:27 2021 -0700
> 
>      kbuild: Don't remove link-vmlinux temporary files on exit/signal

Oops, thanks a lot for pointing out. We are going through the Andi's LTO 
patches and this went unnoticed as it was changed differently (and 
rebase succeeded). Now dropped from the queue.

thanks,
-- 
js
suse labs
