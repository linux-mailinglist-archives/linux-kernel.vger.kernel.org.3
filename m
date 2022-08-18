Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47615597C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbiHRDsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiHRDrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:47:51 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF49A98CA;
        Wed, 17 Aug 2022 20:47:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j17so311707qtp.12;
        Wed, 17 Aug 2022 20:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=gwd1fCexYX3TeFcSSvodLVxxRVE24qi0qHFu+66HlUw=;
        b=pz/F0d0BTzHUl9tcLeRyqrVzroA0Hl9QBIvmSnJOd94WZUI45LcTus7SaaNvsUOA1X
         4+iufz8v7dM69M2dXLK0XvWOm20U8zSPrEnfzNTmKN6NtGqHbmWJ+FldLtNQVdyIGiix
         BIUM+XWxhSkhR1NTwIu0vrjqB3YGhv1achVfvy/oSrTg2ZdjPKhWcDnxOo+t9L7REoBC
         3RcvNX2F+TohskWQ7nGox3AracDCV5MwXCiKDF0c++OrZp8w3viz9FL4J2a4+rnCk6W3
         RlsetkyoyIwmI5nZweBLnStJZMECiSDnB35i9aMJv+phbwqCMOl1iTss6hZBAaU9uyEy
         EUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=gwd1fCexYX3TeFcSSvodLVxxRVE24qi0qHFu+66HlUw=;
        b=JxrI694OMA/gxrycJW9P/AwpvRTsbOXHn6I5xyK+Vc9/1g4Oo6GLe1ETwXQz5f+Iu0
         P+2rLypLEPME08TIuYisx9Pl5sbTZV54bKVHnzVFTv8LkVj/4wbpwH2djWwRDsR7aa8Q
         DGWxjz6QfAWsgHY2KZLifEHw22IGGvlKZtFJlYrEQ9r/PNISQJg7cITkCjRj8al/tdOa
         aH/Eq7LyeLwbg3mY40deu7iHXuOLTmY731FPOeZALpImwHhwHJi+MD2GLR7wSkelPbIj
         Re2cOwOFk2QuCNQfsruQOckC7BRM67UW6Tm/zC6A5Vp/vlvmebWlWOlRQWrhDkXihetT
         BRdg==
X-Gm-Message-State: ACgBeo304msjh3FThWs2pmWLZfgdV2ilksqe6mo8IdCAqap3KzbaTMOe
        6hks+3Gv37RkDlKVACGpk6EIbY9gpGM=
X-Google-Smtp-Source: AA6agR7HVP+1pE/Mgg2CkR1Z5T+A0vF50ElaxWc/p+nO7S9N3eOQ+vXG14dUNPubDaZ6m+nGX1/ERA==
X-Received: by 2002:ac8:7f53:0:b0:343:652:ce62 with SMTP id g19-20020ac87f53000000b003430652ce62mr1083589qtk.514.1660794432634;
        Wed, 17 Aug 2022 20:47:12 -0700 (PDT)
Received: from [192.168.1.201] (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with ESMTPSA id d18-20020a05620a241200b006b919c6749esm727633qkn.91.2022.08.17.20.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 20:47:12 -0700 (PDT)
Subject: Re: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Du Huanpeng <dhu@hodcarrier.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>
References: <20220419051114.1569291-1-seanga2@gmail.com>
 <CAJhJPsUM=LrgrKcoA8xT=4JWt8uxjn6yDxP9vjuZmvb4WvjPZQ@mail.gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <216aebfc-c1c1-c64c-eae3-ad711f310c3a@gmail.com>
Date:   Wed, 17 Aug 2022 23:47:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJhJPsUM=LrgrKcoA8xT=4JWt8uxjn6yDxP9vjuZmvb4WvjPZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kelvin,

On 8/17/22 11:36 PM, Kelvin Cheung wrote:
> Sean, Du,
> I saw you are discussing the PLL rate calculation issue.
> My question is whether the upstream kernel works on your ls1c300?
> For me, it never works, even the earliest version which LS1C support wa=
s merged.
> After the kernel is loaded by PMON, there is no console output at all.
> I also confirm this issue with Yang.
> BTW, my board is 1C300B.
> Are your board is different from me? Or your bootloader?

Unfortunately, I do not have an ls1c300 to test with. This is why I
marked the patch as RFT when I submitted it.

--Sean

>=20
> Sean Anderson <seanga2@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:11=E5=86=99=E9=81=93=EF=BC=9A
>>
>> While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1]=
, I
>> noticed the following calculation, which is copied from
>> drivers/clk/loongson1/clk-loongson1c.c:
>>
>> ulong ls1c300_pll_get_rate(struct clk *clk)
>> {
>>          unsigned int mult;
>>          long long parent_rate;
>>          void *base;
>>          unsigned int val;
>>
>>          parent_rate =3D clk_get_parent_rate(clk);
>>          base =3D (void *)clk->data;
>>
>>          val =3D readl(base + START_FREQ);
>>          mult =3D FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
>>          return (mult * parent_rate) / 4;
>> }
>>
>> I would like to examine the use of M_PLL and FRAC_N to calculate the m=
ultiplier
>> for the PLL. The datasheet has the following to say:
>>
>> START_FREQ =E4=BD=8D    =E7=BC=BA=E7=9C=81=E5=80=BC      =E6=8F=8F=E8=BF=
=B0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> FRAC_N     23:16 0           PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=95=B0=E7=
=9A=84=E5=B0=8F=E6=95=B0=E9=83=A8=E5=88=86
>>
>>                   =E7=94=B1          PLL =E5=80=8D=E9=A2=91=E7=B3=BB=E6=
=95=B0=E7=9A=84=E6=95=B4=E6=95=B0=E9=83=A8=E5=88=86
>> M_PLL      15:8  NAND_D[3:0] (=E7=90=86=E8=AE=BA=E5=8F=AF=E4=BB=A5=E8=BE=
=BE=E5=88=B0 255=EF=BC=8C=E5=BB=BA=E8=AE=AE=E4=B8=8D=E8=A6=81=E8=B6=85=E8=
=BF=87 100)
>>                   =E9=85=8D=E7=BD=AE
>>
>> which according to google translate means
>>
>> START_FREQ Bits  Default       Description
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> FRAC_N     23:16 0             Fractional part of the PLL multiplicati=
on factor
>>
>>                   Depends on    Integer part of PLL multiplication fac=
tor
>> M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] =
it is
>>                   configuration  recommended not to exceed 100)
>>
>> So just based on this description, I would expect that the formula to =
be
>> something like
>>
>>          rate =3D parent * (255 * M_PLL + FRAC_N) / 255 / 4
>>
>> However, the datasheet also gives the following formula:
>>
>>          rate =3D parent * (M_PLL + FRAC_N) / 4
>>
>> which is what the Linux driver has implemented. I find this very unusu=
al.
>> First, the datasheet specifically says that these fields are the integ=
er and
>> fractional parts of the multiplier. Second, I think such a construct d=
oes not
>> easily map to traditional PLL building blocks. Implementing this formu=
la in
>> hardware would likely require an adder, just to then set the threshold=
 of a
>> clock divider.
>>
>> I think it is much more likely that the first formula is correct. The =
author of
>> the datasheet may think of a multiplier of (say) 3.14 as
>>
>>          M_PLL =3D 3
>>          FRAC_N =3D 0.14
>>
>> which together sum to the correct multiplier, even though the actual v=
alue
>> stored in FRAC_N would be 36.
>>
>> I suspect that this has slipped by unnoticed because when FRAC_N is 0,=
 there is
>> no difference in the formulae. The following patch is untested, but I =
suspect
>> it will fix this issue. I would appreciate if anyone with access to th=
e
>> hardware could measure the output of the PLL (or one of its derived cl=
ocks) and
>> determine the correct formula.
>>
>> [1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarri=
er.org/T/#u
>>
>> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loon=
gson1/clk-loongson1c.c
>> index 703f87622cf5..2b98a116c1ea 100644
>> --- a/drivers/clk/loongson1/clk-loongson1c.c
>> +++ b/drivers/clk/loongson1/clk-loongson1c.c
>> @@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk=
_hw *hw,
>>          u32 pll, rate;
>>
>>          pll =3D __raw_readl(LS1X_CLK_PLL_FREQ);
>> -       rate =3D ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
>> +       rate =3D (pll & 0xff00) + ((pll >> 16) & 0xff);
>>          rate *=3D OSC;
>> -       rate >>=3D 2;
>> +       rate >>=3D 10;
>>
>>          return rate;
>>   }
>> --
>> 2.35.1
>>
>=20
>=20


