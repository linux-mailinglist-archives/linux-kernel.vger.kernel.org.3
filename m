Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE364CFC95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiCGLWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbiCGLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD960F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:47:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx21so30895038ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FhmxOKvlcc8i/N769SrIQibs1CETnJmOLmAx2KPERSQ=;
        b=l9dJi1g5ErX4dyr+OZ2BHnuyFUxY4hP/DL/Xx7rGwDIp1rSfc72LpjDPoO2qvF3YNt
         Em8Lm+fxWhZVAG+1svJtkMKXwRha5OdQkluuc9PJ/ZnvvQ280k75Ak1267E+kBWuhxiq
         ZlKGhSntDxhXxAoDUiiV4NbGVIz5rjflrCmSTw4SUEyVKN8ZisgKxS4FayZAuYq5/fAn
         Mtz0qJyLAIaLqWg4LOFpcRvbYzmyrM8+0//x1ATGvQ3Ck3/T7fpPQ3bRjyZ70P5+MDb/
         LrX02WybswJT7CTqehWZYBH4mMIUXcjbkAS96FnvKQEfluEpn7ONC/clOWPYsfWpoJi4
         GKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FhmxOKvlcc8i/N769SrIQibs1CETnJmOLmAx2KPERSQ=;
        b=SpB5z9qLpnCwSvllGzyZ+zyMA6RU6XNeKx9ZDD2yCku7gEdh4G0iQAK05zugQJqsKo
         d2PVgt6c2wC64+Hzz/G64WE+Rh4Wj5yGgMl3EnXmPTKdXmTC6uhQW03fgIktplHJ2NFy
         ZE72CB+IbRSupg6e/778Us0tlTjKgOsi+2WHrM+KA66i9cNrJziDh1zj3hdDwuTvMWjV
         SDRrEKMlf5f7gGzb+4OQZGBjEVeYJvz8ZtD++2SUE5dACrP+tkPpaf+9yAo72ea3+bok
         jDL425WIPgrqpl5YsehvPSYy3UqwCemKpCZB5R7L1WFiuCAsEMh51nBlC5Qv4UAJmSe+
         KQHw==
X-Gm-Message-State: AOAM5335BM7igOWigPyOEC9CS1V/I5EQ2JqbopCEdYth3jX/m9fTRoEG
        irfIEGzbE+Rq0kpRxZdXyaodoHS3jAyj6Za48Bc=
X-Google-Smtp-Source: ABdhPJz11rklaJCS20y+u4M8Gnybb7z4M5DzpozPi+ZWz+SQIjRaJMvHZ5dn/16kcnFPBPED4X4tlg==
X-Received: by 2002:a17:906:c0c9:b0:6db:207:c41f with SMTP id bn9-20020a170906c0c900b006db0207c41fmr8461142ejb.292.1646650053081;
        Mon, 07 Mar 2022 02:47:33 -0800 (PST)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:dceb:fbab:14be:fc99])
        by smtp.gmail.com with ESMTPSA id g26-20020a50ee1a000000b0041631c5b1f3sm2298292eds.30.2022.03.07.02.47.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:47:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] list: always set pos in list_prepare_entry()
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <YiXVD8O3qyDEOGni@smile.fi.intel.com>
Date:   Mon, 7 Mar 2022 11:47:30 +0100
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FE857A7-F8B7-453C-BB81-AA012D45E578@gmail.com>
References: <20220306162635.2930407-1-jakobkoschel@gmail.com>
 <YiXVD8O3qyDEOGni@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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



> On 7. Mar 2022, at 10:49, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> wrote:
>=20
> On Sun, Mar 06, 2022 at 05:26:35PM +0100, Jakob Koschel wrote:
>> In order to assign the result from list_prepare_entry() to another
>> variable, it should also be set when pos !=3D NULL.
>>=20
>> This will be useful once the list iterator is no longer used after
>> the loop.
>=20
> ...
>=20
>> #define list_prepare_entry(pos, head, member) \
>> -	((pos) ? : list_entry(head, typeof(*pos), member))
>> +	((pos) ? pos : list_entry(head, typeof(*pos), member))
>=20
> I'm not sure why then we have () surrounding first pos.
>=20
> Am I right that the original is an equivalent to
>=20
> 	((pos) ? (pos) : list_entry(head, typeof(*pos), member))
>=20
> ?

Yes you are right.

I've just tested this again and seems like my local setup was skewed.

My assumption (from some coccinelle output) was that leaving the TRUE =
case
empty will not do any assignment at all but that's obviously wrong and I
can't reproduce it.

Basically feel free to ignore this PATCH since it just seems to be a =
NO-OP.

>=20
> Then what the difference is made by not using parentheses?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Jakob

