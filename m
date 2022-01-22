Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE94496DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiAVUNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:13:34 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39310 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiAVUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:13:33 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 71D58D7ABB3;
        Sat, 22 Jan 2022 21:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642882411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvFOCrOmpieqrSSeZEK934k3aSXDn2f7mqxg0GSc1BQ=;
        b=KGrgtajbzM+3wtMuXhnH/UEQLn8QdaRml0rIKIDwVtH57pq6G2goXUCzFM1kFiZrWdfruw
        8kg/ZNhk+eaFJbzgPrgLaZ3I6zveh7yHj+VAY0qjJlNoR5ODvfh19I2/dic62lQ8FNSgHr
        /BJ1BrXEhLvnRDhiiwPgnS6TsYN6X5c=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [ASUS EC Sensors v7 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Date:   Sat, 22 Jan 2022 21:13:29 +0100
Message-ID: <2614116.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20220120004540.GD3474033@roeck-us.net>
References: <20220118165316.412735-1-eugene.shalygin@gmail.com> <CAB95QATvQPZ-s4dCWeqKcSZ9Rfx9uK1AyoM9Kk3biPfvXh5r5g@mail.gmail.com> <20220120004540.GD3474033@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 20. ledna 2022 1:45:40 CET Guenter Roeck wrote:
> On Wed, Jan 19, 2022 at 04:25:41AM +0100, Eugene Shalygin wrote:
> > I did not read carefully what I committed and now two small
> > corrections are required (see inline). Should I resend again?
> >=20
>=20
> Wait for a couple of days in case there is test coverage
> or other feedback.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

along with line break/comments fixes.

I'd also appreciate Cc'ing me on this submission.

Thanks.

>=20
> Guenter
>=20
> > On Tue, 18 Jan 2022 at 17:53, Eugene Shalygin <eugene.shalygin@gmail.co=
m> wrote:
> > > +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570=
=2DF GAMING",
> > > +               SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > > +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET
> > Redundant line break.
> > > +       ),
> > > +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570=
=2DI GAMING",
> > > +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> > > +               SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> >=20
> >=20
> > > +struct ec_sensors_data {
> > > +       unsigned long board_sensors;
> > > +       struct ec_sensor *sensors;
> > > +       /** EC registers to read from */
> > > +       u16 *registers;
> > > +       u8 *read_buffer;
> > > +       /** sorted list of unique register banks */
> > > +       u8 banks[ASUS_EC_MAX_BANK + 1];
> > > +       /** in jiffies */
> > > +       unsigned long last_updated;
> > > +       acpi_handle aml_mutex;
> > > +       /** number of board EC sensors */
> > > +       u8 nr_sensors;
> > > +       /** number of EC registers to read (sensor might span more th=
an 1 register) */
> > > +       u8 nr_registers;
> > > +       /** number of unique register banks */
> > > +       u8 nr_banks;
> > > +};
> >=20
> > Forgot to remove doc-comments.
> >=20
> > Thanks,
> > Eugene
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


