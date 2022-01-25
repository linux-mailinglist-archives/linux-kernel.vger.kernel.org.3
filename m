Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7701349BE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiAYW3b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 17:29:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54456 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbiAYW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:29:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-9uUIQKOKPQeq0Z4xvNcZPA-1; Tue, 25 Jan 2022 22:29:28 +0000
X-MC-Unique: 9uUIQKOKPQeq0Z4xvNcZPA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 25 Jan 2022 22:29:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 25 Jan 2022 22:29:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jessica Clarke' <jrtc27@jrtc27.com>,
        Atish Patra <atishp@rivosinc.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
Thread-Topic: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
Thread-Index: AQHYEjqOgNf2MUyCekGjzXIezYRolax0US8A
Date:   Tue, 25 Jan 2022 22:29:26 +0000
Message-ID: <63b1a64fc25d44dabab777bf1f247863@AcuMS.aculab.com>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
 <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
In-Reply-To: <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Currently, SBI APIs accept a hartmask that is generated from struct
> > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > is not the correct data structure for hartids as it can be higher
> > than NR_CPUs for platforms with sparse or discontguous hartids.
> >
> > Remove all association between hartid mask and struct cpumask.
....
> > -static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
> > +static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
> > 			    unsigned long start, unsigned long size,
> > 			    unsigned long arg4, unsigned long arg5)
> > {
> > 	int result = 0;
> > +	unsigned long hart_mask;
> > +
> > +	if (!cpu_mask)
> > +		cpu_mask = cpu_online_mask;
> > +	hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
> >
> > 	/* v0.2 function IDs are equivalent to v0.1 extension IDs */
> > 	switch (fid) {
> > 	case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> > 		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> > -			  (unsigned long)hart_mask, 0, 0, 0, 0, 0);
> > +			  (unsigned long)&hart_mask, 0, 0, 0, 0, 0);

You don't need the cast.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

