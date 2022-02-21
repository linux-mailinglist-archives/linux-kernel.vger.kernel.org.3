Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0E4BD844
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiBUIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiBUIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:12:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF42180;
        Mon, 21 Feb 2022 00:12:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g39so17048208lfv.10;
        Mon, 21 Feb 2022 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AMtyamgl5K/9e9QFxnyeso28NW8FhnQybeCPePa6FPk=;
        b=ZF+/+gAukbkASqH8KQFBW49EAEI8jemBYStwFZWE1iAoiEbOewEt695Po5tGz9XBiI
         lqpJq1zUwdVbFLRbTUvG5/AafkIzNvaiMNrxEWI6P4P3UYA6OnREn5cQMgQIPoQi9ewZ
         Pk3DOYx3/O+HdSelBws4mzMZqBFNcUaw7oD7JIdYpKJ2L3F8zp+f9e7mPcJhYBjr85Rd
         mdNDde9WHLOOXS9RcdU2r5U2G+lC7rdcMJdbBBnqJ4hAdnxlkb8wpTi6AwH2q6vuj1IF
         f8U1CdfcmJHsxbIwv+ph10VwWGLcr2TsTUcOfFUxQrmNgubRPKv+UQJ5lQ33YJFdqqon
         Z2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AMtyamgl5K/9e9QFxnyeso28NW8FhnQybeCPePa6FPk=;
        b=F9qyGcSzGCp9xA2Rcn2qIEXSdpV/qmk82RwrO1rFGxiSGZe5oW2mz5ZzBiB7GoH7XA
         2RlPFrFg7TJpJoBBPg0vw8QzE3XLSGf1whvZqNy0oZVQnk15/oByZBuy9AId4iAvcUlA
         wRkgIQHmq7FzjHvLg3YBFZ/7S/WFGPvQ1nkk/o2cQ4U9oR5JCKKNyA/qLpW980NdCfU8
         SoUrPA+4btr/S3Cqnf853fPxpijACKCjJVqvsm1T973Ud7swLzNaUKTnPrmtoxje2d9Z
         h6GE4DT3+cKyaeEsjs4UNqtIfO+N7p4TUaHgot/8MzxTmk6SYjjDlkk72iUNLCNHOqbO
         Tpuw==
X-Gm-Message-State: AOAM5325on5FZAjOYBg+R++lcNMTrbxQsz8ZbzwUXpA8yY6qg0D9dibM
        o/vxrCgCLZWujDiuxQUinw4=
X-Google-Smtp-Source: ABdhPJywWtoHMTPRyDz+QDtD+lHOHcedBIWHiNA0i4m70aAvOHhtTX3ZJW2OLMRA4O6iGfpngKtM1w==
X-Received: by 2002:a05:6512:230d:b0:443:972f:fd7e with SMTP id o13-20020a056512230d00b00443972ffd7emr13460544lfu.322.1645431128461;
        Mon, 21 Feb 2022 00:12:08 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id t20sm1036483lfe.277.2022.02.21.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 00:12:08 -0800 (PST)
Message-ID: <43992c7a-c8e7-29a6-d0f0-f69abccd62a1@gmail.com>
Date:   Mon, 21 Feb 2022 11:12:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in thrustmaster_probe
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>
Cc:     syzbot <syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com>,
        alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, syzkaller-bugs@googlegroups.com
References: <000000000000d181a205d874c066@google.com>
 <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com>
 <nycvar.YFH.7.76.2202210900420.11721@cbobk.fhfr.pm>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <nycvar.YFH.7.76.2202210900420.11721@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2/21/22 11:01, Jiri Kosina wrote:
>> Looks like missing check for malicious device. Need to check number of
>> endpoints before accessing endpoints array
>> 
>> 
>> #syz test
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Thanks Pavel. Could you please send the patch with proper changelog and
> SOB my way?
> 

I've already posted the patch :) You can find it here [1] (you are in CC 
of course)



[1] 
https://lore.kernel.org/all/20220220160114.26882-1-paskripkin@gmail.com/




With regards,
Pavel Skripkin
