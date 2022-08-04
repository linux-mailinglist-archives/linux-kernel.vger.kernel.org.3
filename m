Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E4589839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiHDHQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHDHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:16:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388545C343;
        Thu,  4 Aug 2022 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659597387;
        bh=oc1O2fPy86MLR9on/4I4+s39V+Vb+PCt1rvjb0LYkOY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PxNTHLa2k/Zbg+dSGTUhdxetK3v7W5se6qrcFG5akgWHcxTXRcpfcuE9It71HAj2O
         M63IA01jWlvaPGBtGb+uoen3Ve9CtLSe91X9WCANYr1GVy4jSHnkwjxrcGwfFUQhLm
         B1SwnLYaha7HGM34vmcgvOL3uxwXeKTFyPBFsqRc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.176.33]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1oNsoV0Gqu-004W85; Thu, 04
 Aug 2022 09:16:27 +0200
Message-ID: <35e860bb-c76c-ca5f-3f48-2bf6cb798689@gmx.de>
Date:   Thu, 4 Aug 2022 09:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: selection: Add check for valid tiocl_selection
 values
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de> <YuV9PybMPgc83Jis@p100>
 <1eb62346-304b-54d5-8a62-8a35888d51bd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <1eb62346-304b-54d5-8a62-8a35888d51bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jRjVNDDdqJHTUKkL7mG+988yDQwcDTyIxbhpOuX4s43shVA9Dnn
 5Cvvi8qFu3DTjPAR/E+WPnIE8z9iciQ6Tf9wG/dvgCcJXxl1wbZdtQu9E9KpfxbzqqzxeaO
 jSdPCN8QQ8zzlV7s21qEQ5jCHSGV3tSiQD6ixnIlwoE+fZwGFZDorgdwWgrk3BDke3rDOYa
 s/qZseDPGQt5C/ZekneLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4K5fc628s8A=:XCAXeu6N7qnxQkJwrpOxpL
 wyCC+Qj/fffBLtSuyuC0m767p5PPfBVxHtIEB/ABrvowUqZdizfH9OxmlYvD3RP0RBRbRY3ga
 l8mvJzbjGNb1HcaobCSYnlNOJDD8pNKscvzLoGh9Jf0wWnMiwqNUtjJI51/dKDFWoU5CBo76P
 KzBE4q/kN3AHcqEGoCDIiyXl41FfdD8pXc6HptplYcXB/8GsJAtz/t/3V6qfCOPtQC7xNKF7S
 0pqfJweTYJ+8pqcq0fy2OKspKmRKWo8z7bhoMwYalrMYuyL+YsDVWSYMBNS5qbmIXcKf3upef
 2o41Z0QVBo9qxwpvH+8kQiBHBk/ZEg5jHICcJuUB3ZvxCF/D+ZuM3KZOgql4e7PAMTZpA4twM
 gPfuSFm3vD18t9XBnwgJnAKS+0sSzJYkBEeoy8tngaYgb4ji+x/Ex0bSp+WwOrGIcAEY/aKd6
 aKr+a27jAR1jk/7L7iUAnIY2r5WFz0NYGY+5/lBRIJbooNIYLsoRP4SdZ/pDY5eIUVz/y2mFN
 /bYm6EDEzzUEZThnisptKj4uImXxtIRmrqylzEwMAJTOwL2nGf8/YYFZ6UuAqF+EDIugLlNs8
 OTKRqy5Gdo1VQuJ4IpjVDrsa3YStYfSjHTGFEEifrsHBW0jreAcGC3BGd7lOVUHif8oQKc9zV
 tYe4pQXpX3OfxoQk3b4tMnThcBa28ucR+lcxi8kLHtu7xE1YEiTjh90raPcYaSUavJcFh/4b+
 zlClaruuhBcf6jl8BRLzNGXguI9I30dH9soFD+M4CeAjtdpE8B2opgiMAzPSzzWpy6xk8Dkfo
 TWyQAMuvL7WQIAkKyh2zuq+LDQbu7uRm1E5EUYcwCZhwMzxWWfKJZkVhfq3zQvQ/KW7zswsVM
 ykAwI2M2+ZlEofDZzxvX8xcR5MgIP2lMrely93n4lnbhIoi1xezltWJbDRZwFrJFXyAxLe98l
 VwvXRCwF3P+jimfzcudB647Zm41WAMwZrrdyGvSUKHfOb9KwmxJVNTDWbAtMkxd4uVjCd603e
 iXcHI9quiP9ohCOvpNES5AZSQwx9MQ2aYI570s3S2I2Q3jOOvd0H6c6nKwKeIf/RhQzlazrp1
 PQIvYarnKAQLHY3tZfYO4QE+F7ChmUOP0Tynq9u+kfAkUImAqTrBlEhzA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

Thanks for looking into this patch!

On 8/4/22 07:47, Jiri Slaby wrote:
> On 30. 07. 22, 20:49, Helge Deller wrote:
>> The line and column numbers for the selection need to start at 1.
>> Add the checks to prevent invalid input.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
>>
>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>> index f7755e73696e..58692a9b4097 100644
>> --- a/drivers/tty/vt/selection.c
>> +++ b/drivers/tty/vt/selection.c
>> @@ -326,6 +326,9 @@ static int vc_selection(struct vc_data *vc, struct =
tiocl_selection *v,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 if (!v->xs || !v->ys || !v->xe || !v->ye)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>
> Hmm, I'm not sure about this. It potentially breaks userspace (by
> returning EINVAL now).

Right.
According to the code below, my interpretation is that all xs/ys/xe/ye val=
ues
should be > 0. But of course I might be wrong on this, as I didn't find an=
y
documentation for TIOCL_SETSEL.

And if userspace tries to set an invalid selection (e.g. by selecting row =
0),
my patch now returns -EINVAL, while it returned success before.

> And the code below should handle this just fine, right:
>>       v->xs =3D min_t(u16, v->xs - 1, vc->vc_cols - 1);
>>       v->ys =3D min_t(u16, v->ys - 1, vc->vc_rows - 1);
>>       v->xe =3D min_t(u16, v->xe - 1, vc->vc_cols - 1);

It "handles it fine" in the sense that it can cope with the
input and will not crash.
But it returns (maybe?) unexpected results...

For example, if a user selects row 0 (where I assume he wanted to set
the first line), he instead selects the last row.
I'm not sure if this is the expected behaviour.

Do you know of any userspace program which breaks because of this?

Helge
