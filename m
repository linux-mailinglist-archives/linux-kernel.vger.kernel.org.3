Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E644CED54
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiCFTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiCFTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:20:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93F5577B;
        Sun,  6 Mar 2022 11:19:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so27735994ejb.4;
        Sun, 06 Mar 2022 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RWG5yH3AWrpWTwAcnLFzgM65C6lndUaF3A9rlT3VpsU=;
        b=NWF68WLsIBqfcDq3zpJAB03gsXDKDLdGJYPHNJJUZiaCBp4yQj26EI8nIFMR+f+xN5
         lRp6OrUhkZ5BXDdSsVCFdil7bbP2J1RE1C5UTnAMlJ9Rx81vDLcIUYqItfp9CFXGZvEi
         NfwYwFVfYT7+W4wHgcH35E/ZzlK2t4ra6D/83deLgihL9YKGOfqgapVe7OG/rKOBTxCH
         X9dzD2kiCw8idguG7pk7jtk+qT0DjHdwCPRfnzpJazk6B3rr4wdwzyptZQvkh6WP/A94
         Mj12Jv25BmA0lA+COshLoV495i5HYaiBW/mCCYdsMLUFdmL9RiHyyRhCUeneqak7U/d/
         lS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RWG5yH3AWrpWTwAcnLFzgM65C6lndUaF3A9rlT3VpsU=;
        b=MBXFQKo7jYaXh4S3KadcoSDVJENbwkEj2hcvez9YqByrlRvyo9nyZ0BI7ik+2tIAfa
         jEVN9DcYIrA8UELr/nVfsXzuodyAkBl+ETgq1vQkn1C2uktUNQk4o0/lc3qzaEAV09Gs
         almArjUSnCMADlUnwDn8sb+TPsnQAYNKTc+JOE6HDY94wdZGDQQ4JYA7CT5xkFng+HiL
         sI+K0+I1G9onh/9Kf5XZ33KVrPBvCp645vpvc19AszqAlQFQLMghabhJMmNIcgZUeAM/
         Ih/yjdTn7eHAIdM4OzukvYxEgT8cKsWcUkB6HdhB7OiSH0n/DobxA9d/dPI+EiGxlU5f
         cQzw==
X-Gm-Message-State: AOAM530OlHXX8PCifl/jjdz+h3yZ/y94jUQWDurMziuekSR6p2GKQ6Ow
        wuUXpesFjq1bovMlE3LYyFQ=
X-Google-Smtp-Source: ABdhPJyx89Yb5QqwohfRvWf3kRU0UIsIgclDae3DFDBWsrGCb3peJ3WzpPDljJTd890gG0rUxLq55Q==
X-Received: by 2002:a17:907:78d6:b0:6da:825b:96d with SMTP id kv22-20020a17090778d600b006da825b096dmr6872056ejc.460.1646594388262;
        Sun, 06 Mar 2022 11:19:48 -0800 (PST)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:dceb:fbab:14be:fc99])
        by smtp.gmail.com with ESMTPSA id kv9-20020a17090778c900b006da693d5e91sm3960268ejc.122.2022.03.06.11.19.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 11:19:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 01/26] usb: gadget: fsl: remove usage of list iterator
 past the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <CAHk-=wheru6rEfzC2wuO9k03PRF6s3nhxryCAnwR5bzKwPV2ww@mail.gmail.com>
Date:   Sun, 6 Mar 2022 20:19:46 +0100
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <34D2D040-8BF4-4F70-830D-0715A8BE7873@gmail.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
 <20220306175034.3084609-2-jakobkoschel@gmail.com>
 <CAHk-=wheru6rEfzC2wuO9k03PRF6s3nhxryCAnwR5bzKwPV2ww@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 6. Mar 2022, at 19:39, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Sun, Mar 6, 2022 at 9:51 AM Jakob Koschel <jakobkoschel@gmail.com> =
wrote:
>>=20
>>        /* make sure it's actually queued on this endpoint */
>> -       list_for_each_entry(req, &ep->queue, queue) {
>> -               if (&req->req =3D=3D _req)
>> +       list_for_each_entry(tmp, &ep->queue, queue) {
>> +               if (&tmp->req =3D=3D _req) {
>> +                       req =3D tmp;
>>                        break;
>> +               }
>>        }
>=20
> Honestly, I think many (most?) of these would be a lot cleaner as
>=20
>        list_for_each_entry(tmp, &ep->queue, queue) {
>                if (&tmp->req !=3D _req)
>                        continue;
>                req =3D tmp;
>                break;
>        }

Alright, then I'll go ahead and adjust them. I tried keeping the code
as similar as possible because in other cases it might be less cleaner
inverting the condition.

>=20
> and in fact maybe that 'tmp' would be better named 'iter' or similar
> (maybe 'pos', which is what the list.h macros themselves use for the
> iterator naming), just from a naming standpoint.

I agree, also here I simply kept it to what we concluded in the other
thread. I also think using 'iter' would make more sense.
>=20
> Because it's not really some temporary variable, it has a real use.
>=20
>           Linus

Jakob

