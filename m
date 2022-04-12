Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DC4FDFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351801AbiDLMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352944AbiDLMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D44B40
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:02:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so17910671ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYlSwRs2xXTAAyUlwb+gbXuW16FUgB8AcvnUgAkw87M=;
        b=eSbceTFB98b3Z4e++6Y2eKyh0djI4T4ned0/KGkHF4WkQ2ae1MrCfN/x1DtyjdQ9EK
         I6uRjCoOv2AxG0UVJB0EOUOEcKG1gRlCsYmqXVCMaB1783YxmdMMk9Er1euKcvHliDpE
         tRH2iCH/Aaoe6tasaDrdqEiifWeCJ3oo0c8Gps11Zz8r3CFiu+WckRFSke/7vQpAhA39
         SdyWjtnFobiiFiq0baedSX18wfT0ay8xSeoyNDUUujyaFI7DfjEyqROymvDx4JAbt5cB
         Q9dW0CrEFyWsiFUbVC+RGVEBAtPjMno47ARxUA30DU7nZ+ZhEguqThGbutt1Rd0YYr/W
         YCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYlSwRs2xXTAAyUlwb+gbXuW16FUgB8AcvnUgAkw87M=;
        b=W0PfJwKq/c7samWYmmteiDUbbRjFgRpj+06gPfwQT54BZHbBKbJOjD91XxzcmLozwZ
         +cffZA70LjtH/fymh2Ia97Tvn/7KEzXMS+H/JZIsjPI+gAJfOvSzzLkojBTsNS86rIMg
         uA/TNDCUf/Zz4oi6Axb+f50BWJBC8daiYD0TFPS2WziTAmBUj4glZAinSEhBw4+sm8Yn
         aPvq6GIBkMZiNwTL3ZkPdkF0hJ9+6/HmF7VCqkfQ70ZAbqWzow+TAZCiX9vwPBIlD7nG
         H5RD2JdtPFLCvoa/bhFtu1xsR+/zl1la0jt8kN25qFrdEgOaUg8eB0lbqTJ5Vh0HPHmv
         2RUg==
X-Gm-Message-State: AOAM532ggP/8fN5k7AR/ACeCJ/YwLKDS0Ko7DruELjJlxejywX3pjAKf
        hYw2WE5vx3Up3B7n17dKv+Y=
X-Google-Smtp-Source: ABdhPJwPcRInSEEVAplx2Q7xSQldnlj/l6p5lEplZaCg8iRKCy5wsP3rhJrj4lvajacO3js5nLJNfQ==
X-Received: by 2002:a17:907:d04:b0:6e8:8cbc:e86a with SMTP id gn4-20020a1709070d0400b006e88cbce86amr9739701ejc.194.1649761338744;
        Tue, 12 Apr 2022 04:02:18 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm16990227edz.35.2022.04.12.04.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:02:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/2] f2fs: use separate list iterator variable to call
 list_move_tail()
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <4d54f494-b143-8885-a31e-924a83409e2d@kernel.org>
Date:   Tue, 12 Apr 2022 13:02:17 +0200
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <632AA316-A1B4-4E2C-B5FD-204FD3BE8633@gmail.com>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
 <4d54f494-b143-8885-a31e-924a83409e2d@kernel.org>
To:     Chao Yu <chao@kernel.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12. Apr 2022, at 11:40, Chao Yu <chao@kernel.org> wrote:
>=20
> On 2022/4/1 6:16, Jakob Koschel wrote:
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element
>> [1].
>> If no break is hit or the list is empty, 'next' will be NULL and
>> list_move_tail() should be called explicitly on the head directly.
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> fs/f2fs/segment.c | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 22dfeb991529..81ef2c3d08e5 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -4175,16 +4175,20 @@ static void release_sit_entry_set(struct =
sit_entry_set *ses)
>> static void adjust_sit_entry_set(struct sit_entry_set *ses,
>> 						struct list_head *head)
>> {
>> -	struct sit_entry_set *next =3D ses;
>> +	struct sit_entry_set *next =3D NULL, *iter =3D ses;
>> 	if (list_is_last(&ses->set_list, head))
>> 		return;
>> -	list_for_each_entry_continue(next, head, set_list)
>> -		if (ses->entry_cnt <=3D next->entry_cnt)
>> +	list_for_each_entry_continue(iter, head, set_list)
>> +		if (ses->entry_cnt <=3D iter->entry_cnt) {
>> +			next =3D iter;
>> +			list_move_tail(&ses->set_list, &iter->set_list);
>> 			break;
>=20
> return;
>=20
>> +		}
>> -	list_move_tail(&ses->set_list, &next->set_list);
>> +	if (!next)
>> +		list_move_tail(&ses->set_list, head);
>=20
> list_move_tail(&ses->set_list, head);
>=20
> Then we don't need @next variable, right?

Of course yes, good spot! I'll fix and resend a v2 in the next days.
Thanks for the input.

>=20
> Thanks,
>=20
>> }
>> static void add_sit_entry(unsigned int segno, struct list_head *head)
>> base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550

