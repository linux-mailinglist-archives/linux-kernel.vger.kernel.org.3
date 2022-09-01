Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA75A9224
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIAIe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiIAIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:34:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35E128566
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:34:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z6so23358167lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zdKf2GU/029X1i1nZhbauxVm45u7tJ/0ih6Hx+pKrBM=;
        b=iOTyDaA5qBzZnGKmfEPl6ByrywxzC3nZx51SmMXhUfMrmY6jTAN2IP9XaqlTqPAZY5
         sGOGDQybEEmjb8cSKMeNvpmp0rPrNdrr+q3NCw0KcSw1CYx6GwEZGl7+w5xQGiX6/UEY
         Oc+zXTM1XlKZrHiBpe2ZnbvZc5w2EjffeyHUBd+54dUPwHLO6gEp9SzakxCaDSKv0m96
         ps0UWCnyKV2P5W8vonTulb0AN5SgHNIL59C/8kwGc7sURgINVqA0sRWHylxw/PRH9/s4
         kaUaGihYtSdwyvtFmbEqgwQujsp9Uibh3fCPD5V1DZi7TVnqc4nbE0eXc35AwOURCF+F
         wPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zdKf2GU/029X1i1nZhbauxVm45u7tJ/0ih6Hx+pKrBM=;
        b=cDSHbaj3InHC5bcSzKkLJwRKhSJymx7j6INyS/OpOhWgj5wZBjhvxUIeC3ThfaATC8
         PPf8luPOhJjj3oXcP7gDAjTWnu5ejMIPW3uR1BOBrS13PexONdQSaW3i+ixJWPqzrw7n
         Cpw47OMb2NtU4+mvgk0UfEOvfN/7ma3UK3O6USsGmErvo53MSNTeMs0moE/Npppj5Jgp
         +t1rxy2H3YPi8WUA9SKI11yL10udo4IbbVKs3UwgNEzVyDffA6/HimE01hNlqMxa5wZC
         Qnz6KggqDF11cX2KBD3S/Jq+kGpBS//aH6+QjCFGU4xYkXRwLFuk0z0O6npWbxv4WZFh
         e4AA==
X-Gm-Message-State: ACgBeo14Nt528U/8Sl5GeNVyHJOcFYL09e1hct7cIqZUYpYz8cr22ZMq
        ca3BbafAYuRFK2/TC4ttap4anFBAL1ThNHfUH7ILr0joQDY=
X-Google-Smtp-Source: AA6agR5jhatVHrFF5q4/HGpIxNLUhMCeUtZerrvXfmtwEERfpvOC2i4/nXoAxEFMPqvotHuMz5YVI5UiC5lkKkfAt7U=
X-Received: by 2002:a05:6512:c0c:b0:48d:1e9d:aa14 with SMTP id
 z12-20020a0565120c0c00b0048d1e9daa14mr11136553lfu.322.1662021281851; Thu, 01
 Sep 2022 01:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220830082620.1680602-1-ben.dooks@sifive.com>
 <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com> <cefcf96f-5bcc-d134-fbe5-d1169313b6f3@codethink.co.uk>
 <CA+ZOyajWRUFppg26O1XHfRuJHWB3jk-=-i=FBV9XYgHgshuwQA@mail.gmail.com> <e9132264-bec6-0f39-ff42-d8b6e95b2492@sifive.com>
In-Reply-To: <e9132264-bec6-0f39-ff42-d8b6e95b2492@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 1 Sep 2022 16:34:30 +0800
Message-ID: <CANXhq0qzqUHkWWAT3puANMt2HCDE38QFYYyAcpZuiQW_Umgueg@mail.gmail.com>
Subject: Re: [PATCH] soc: sifive: ccache: reduce printing on init
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Zong Li <zongbox@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:55 PM Ben Dooks <ben.dooks@sifive.com> wrote:
>
> On 31/08/2022 06:22, Zong Li wrote:
> > Ben Dooks <ben.dooks@codethink.co.uk> =E6=96=BC 2022=E5=B9=B48=E6=9C=88=
31=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A81:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> On 30/08/2022 17:30, Conor.Dooley@microchip.com wrote:
> >>> On 30/08/2022 09:26, Ben Dooks wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you kn=
ow the content is safe
> >>>>
> >>>> The driver prints out 6 lines on startup, which can easily be redcue=
d
> >>>> to two lines without losing any information.
> >>>>
> >>>> Note, to make the types work better, uint64_t has been replaced with
> >>>> ULL to make the unsigned long long match the format in the print
> >>>> statement.
> >>>>
> >>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> >>>> ---
> >>>>    drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
> >>>>    1 file changed, 11 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive=
/sifive_ccache.c
> >>>> index 46ce33db7d30..65a10a6ee211 100644
> >>>> --- a/drivers/soc/sifive/sifive_ccache.c
> >>>> +++ b/drivers/soc/sifive/sifive_ccache.c
> >>>> @@ -76,20 +76,17 @@ static void setup_sifive_debug(void)
> >>>>
> >>>>    static void ccache_config_read(void)
> >>>>    {
> >>>> -       u32 regval, val;
> >>>> -
> >>>> -       regval =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >>>> -       val =3D regval & 0xFF;
> >>>> -       pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
> >>>> -       val =3D (regval & 0xFF00) >> 8;
> >>>> -       pr_info("CCACHE: No. of ways per bank: %d\n", val);
> >>>> -       val =3D (regval & 0xFF0000) >> 16;
> >>>> -       pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val)=
;
> >>>> -       val =3D (regval & 0xFF000000) >> 24;
> >>>> -       pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1=
 << val);
> >>>> -
> >>>> -       regval =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> >>>> -       pr_info("CCACHE: Index of the largest way enabled: %d\n", re=
gval);
> >>>> +       u32 cfg;
> >>>> +
> >>>> +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >>>> +
> >>>> +       pr_info("CCACHE: %u banks, %u ways, sets/bank=3D%llu, bytes/=
block=3D%llu\n",
> >>>> +               (cfg & 0xff), (cfg >> 8) & 0xff,
> >>>> +               1ULL << ((cfg >> 16) & 0xff),
> >>>
> >>> This is just BIT_ULL((cfg >> 16) & 0xff), no?
> >>> Would be nice too if these were defined, so you'd have something
> >>> like BIT_ULL((cfg >> SETS_PER_BANK_SHIFT) & 0xff)
> >>>
> >>> I do like the cleanup of the uint64_t & cutting down on the prints
> >>> though :) Again, it'd be nice if you and Zong could collaborate on
> >>> a combined v2.
> >>
> >> I think even BIT_UL() would do here, if someone is going to make a
> >> cache bigger than 2GiB we'll probably be quite old by then, so v2
> >> might have the last two values down as %lu.
> >>
> >
> > Hi Ben,
> > Thanks for your suggestion, If you don't mind, I will take this into
> > my V2 patchset.
>
> Thanks.
>
> I may well post v2 of this tomorrow with the BIT_ULL() suggestions
> from Conor, or even down to BIT_UL() and use %lu as noted.
>

No problem Ben. Could you please also add me in the thread of your v2,
then I can take it and send out my v2 patchset. Thanks.

> >
> >>> Thanks,
> >>> Conor.
> >>>
> >>>> +               1ULL << ((cfg >> 24) & 0xff));
> >>>> +
> >>>> +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> >>>> +       pr_info("CCACHE: Index of the largest way enabled: %d\n", cf=
g);
> >>>>    }
> >>>>
> >>>>    static const struct of_device_id sifive_ccache_ids[] =3D {
> >>>> --
> >>>> 2.35.1
> >>>>
> >>>
> >>> _______________________________________________
> >>> linux-riscv mailing list
> >>> linux-riscv@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >>>
> >>
> >> --
> >> Ben Dooks                               http://www.codethink.co.uk/
> >> Senior Engineer                         Codethink - Providing Genius
> >>
> >> https://www.codethink.co.uk/privacy.html
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
