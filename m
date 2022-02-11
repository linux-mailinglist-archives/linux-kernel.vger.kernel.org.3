Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3784B20E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiBKJB2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Feb 2022 04:01:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiBKJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:01:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52255218
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:01:24 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-181-ZVqkzH3HN4O8yF2JIYiCzA-1; Fri, 11 Feb 2022 09:01:20 +0000
X-MC-Unique: ZVqkzH3HN4O8yF2JIYiCzA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 11 Feb 2022 09:01:18 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 11 Feb 2022 09:01:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yury Norov' <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Tariq Toukan <tariqt@nvidia.com>
Subject: RE: [PATCH 03/49] net: mellanox: fix open-coded for_each_set_bit()
Thread-Topic: [PATCH 03/49] net: mellanox: fix open-coded for_each_set_bit()
Thread-Index: AQHYHtG4yKZzG4lg2kmilpMmHYE0PayODZPQ
Date:   Fri, 11 Feb 2022 09:01:18 +0000
Message-ID: <cb8081d413df4a008e32358b23732dd4@AcuMS.aculab.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-4-yury.norov@gmail.com>
In-Reply-To: <20220210224933.379149-4-yury.norov@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov
> Sent: 10 February 2022 22:49
> 
> Mellanox driver has an open-coded for_each_set_bit(). Fix it.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cmd.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> index e10b7b04b894..c56d2194cbfc 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> @@ -1994,21 +1994,16 @@ static void mlx4_allocate_port_vpps(struct mlx4_dev *dev, int port)
> 
>  static int mlx4_master_activate_admin_state(struct mlx4_priv *priv, int slave)
>  {
> -	int port, err;
> +	int p, port, err;
>  	struct mlx4_vport_state *vp_admin;
>  	struct mlx4_vport_oper_state *vp_oper;
>  	struct mlx4_slave_state *slave_state =
>  		&priv->mfunc.master.slave_state[slave];
>  	struct mlx4_active_ports actv_ports = mlx4_get_active_ports(
>  			&priv->dev, slave);
> -	int min_port = find_first_bit(actv_ports.ports,
> -				      priv->dev.caps.num_ports) + 1;
> -	int max_port = min_port - 1 +
> -		bitmap_weight(actv_ports.ports, priv->dev.caps.num_ports);
> 
> -	for (port = min_port; port <= max_port; port++) {
> -		if (!test_bit(port - 1, actv_ports.ports))
> -			continue;
> +	for_each_set_bit(p, actv_ports.ports, priv->dev.caps.num_ports) {
> +		port = p + 1;

This is an 'interesting' change in behaviour, and looks like a bug fix.
Did anyone actually test the old code?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

