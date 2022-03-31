Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F44ED855
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiCaLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiCaLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:22:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570916E231
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:20:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so47351119ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Owycg3ONoUAQIT8nK6FMRIvNoqVRboRVB31x1ap6Y1U=;
        b=cwJZTX3+f4dIONJ6Zf+94BNbZ83IKBiEnBvN086Be2l2JY26BPZF8IyxzirNDvSHN7
         B6kClStYHWhTQaCriEGogZe930F44/JC6rVu/yww4WpeClFQXTQxYftUpl4ZBVp8zN1G
         PxvLyZFi2bE/g+wA9UvBBs/HUAJMlFVx7mbZBgfX/Ap5q0G/fDbcNGhhS0WLd2VWs2iO
         Iu5j4w+5G1zDBDC5bGKKV6jEnQgTnXbblhc0aZ6x9dYQ08vmuEEU80d2O2/zErBeOgUG
         JdeF4QnVwAjiClHhUARBdt0DDiVAmTnsGQb2KgKMpHfblXHk58b3OQ1zOlroJRGAwcLS
         ibsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Owycg3ONoUAQIT8nK6FMRIvNoqVRboRVB31x1ap6Y1U=;
        b=telWOVnkIHyI79lbvdunaPkfcHlSrR9R3kgpspdcjmURX7Wt5RYz89nLbv1+aHCEPG
         J1LezsYSkwFaEFwJBDSBETRXEEPEjzAi5I4P7WG3RHuAMa+QqQEVz/St2/vDXg6uyddn
         XQc3bwT2MHpqEga8fzusan/SybaDtNRCQc39V8HDoEFIkHvls8WHmNMAl8uOkctoVhBb
         7cfWv8HNbkDRKCw2PJkaWDqTp6q2IFhFaBha0AtDN+ecgXxo4wjiY13KnR4k84sRchew
         vXs/vQYCJ1MoSRMYFD0SyzrZ9cLl+WLouwP9+3W6CcTJAAzpNGN1oyrwfPIbzoLixZKz
         AI+A==
X-Gm-Message-State: AOAM530bLLDVAhbXGmwt7o5tN/lwpgc2fs01Gtyegf+6/mDNJ+/iYWTh
        MzDtKO0hPaJGkmpXcWw7L3o=
X-Google-Smtp-Source: ABdhPJyRRGeidVfu9zGXUYbNwOW+W0fcGAHT20/P7XTxz2hSx/wod/ZiJE0mVywvzPOXZvDKBXUykQ==
X-Received: by 2002:a17:906:a08b:b0:6cf:65bc:e7de with SMTP id q11-20020a170906a08b00b006cf65bce7demr4564997ejy.220.1648725651961;
        Thu, 31 Mar 2022 04:20:51 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090695d400b006e0b0022b29sm7309801ejy.186.2022.03.31.04.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:20:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virt: acrn: fix invalid check past list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220330075742.GA22544@louislifei-OptiPlex-7050>
Date:   Thu, 31 Mar 2022 13:20:50 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>, h.j.bos@vu.nl
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E68C33F-9CBB-418C-A11D-2AD863C0B19A@gmail.com>
References: <20220319203819.2559993-1-jakobkoschel@gmail.com>
 <20220330075742.GA22544@louislifei-OptiPlex-7050>
To:     Li Fei1 <fei1.li@intel.com>
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


> On 30. Mar 2022, at 09:57, Li Fei1 <fei1.li@intel.com> wrote:
>=20
> On Sat, Mar 19, 2022 at 09:38:19PM +0100, Jakob Koschel wrote:
>> The condition retry =3D=3D 0 is theoretically possible even if =
'client'
>> does not point to a valid element because no break was hit.
>>=20
>> To only execute the dev_warn if actually a break within the loop was
>> hit, a separate variable is used that is only set if it is ensured to
>> point to a valid client struct.
>>=20
> Hi Koschel
>=20
> Thanks for you to help us to try to improve the code. Maybe you don't =
get the point.
> The dev_warn should only been called when has_pending =3D true && =
retry =3D=3D 0

Maybe I don't understand but looking isolated at this function I could =
see a way to call
the dev_warn() with has_pending =3D false && retry =3D=3D 0.

> 		list_for_each_entry(client, &vm->ioreq_clients, list) {
> 			has_pending =3D has_pending_request(client);
> 			if (has_pending)
> 		}
> 		spin_unlock_bh(&vm->ioreq_clients_lock);

imagine has_pending =3D=3D false && retry =3D=3D 1 here, then client =
will not hold a valid list entry.

>=20
> 		if (has_pending)
> 			schedule_timeout_interruptible(HZ / 100);
> 	} while (has_pending && --retry > 0);

since has_pending && --retry > 0 is no longer true the loop stops.

> 	if (retry =3D=3D 0)
> 		dev_warn(acrn_dev.this_device,
> 			 "%s cannot flush pending request!\n", =
client->name);
client->name is accessed since retry =3D=3D 0 now, but client is not a =
valid struct ending up
in a type confusion.

>=20
> If retry > 0 and has_pending is true,  we would call =
schedule_timeout_interruptible
> to schedule out to wait all the pending I/O requests would been =
completed.
>=20
> Thanks.

Again, I'm not sure if this is realistically possible. I'm trying to =
remove
any use of the list iterator after the loop to make such potentially =
issues detectable
at compile time instead of relying on certain (difficult to maintain) =
conditions to be met
to avoid the type confusion.

Thanks,
Jakob

