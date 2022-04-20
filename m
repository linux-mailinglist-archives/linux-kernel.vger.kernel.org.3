Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F19650813B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348397AbiDTGfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbiDTGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:35:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272111C0A;
        Tue, 19 Apr 2022 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650436356; x=1681972356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IhZ8e8gL4lOGoagkP87PnWZmT8Adwl1YuO9SSC6yruQ=;
  b=pO2DJj7T5SlF4t9EyXqOtqgz/Q8Q4GjvY1VO3izesVHhwVNOxmZLsj71
   TTyHc0xGGYaixmJ4JU4hDsiN2x0rjzO1AuL4jdAKvhlKHoeWndfc4C5nL
   wd0oR5hVpAQAD4pfMGQ2UdqQIOK/UPvye/NeoEqjP5mxfDSGXbMRY3Qj8
   rVF2bQWc9JhzNeR/lhkMUJPLmfcejK6Ouar8MMMSFfgVjr1KNwV8UsdFV
   +Yujs5//WAVQgrJxuPdhqBwDpeTmjR7Ij1HzURmJy9qxDcWgz1P4NT1k/
   3osYADZSBNc2j1v+60TPQv9cleNbnpc32RbO3P7fkWGV+hzP4HrB/uk6h
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643698800"; 
   d="scan'208";a="161063687"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 23:32:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 23:32:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Apr 2022 23:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJyyOd8dpMAJBAYBFZbWsABzOs+/8WzqYpAPyNKz0Yj28uNJ43LND8XSmvTkiNddRZu5sQJ6qphbee6UUqChNuBEoVhwWV0ngXxgQ3d7nOa31VqpthzcGc8cPsARMAgT6NZynkidGu7SwTCUwoGJk2jyNQ1MausUagk8ilHy/5TWTAJu2CLy9zGghY5QUKFGJM/OCc57ie6qqx7+ZRqcY1HT4zPLMDmWijOsfo9J+FcXhxo4eGDarvB76fQXGdUxjk+PKCPm6DyDp4DPiU41ZCFnX6ar12DTbBJHfV0YIxB2e/0mH/+Z55kQFn7WpjN+gup3FQhgbesGco7fF9s1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCnE+RYz/C58A3ZQ+9YN6PxGZ+F8lj3e0pAahhMInKg=;
 b=ERRtAR6hBp93gHjlNNbi8n81Mt5UEN6jyuPu2as2inLE22nT33lCXOlKK8OFKfc8buYIYWsazKT5lZqE3d/foanLBY5lFo+FJ15eP1lEoBG7xqzMiJculDz9S1Y3XVpLhdXXookFY8Gdnpc3lWmRsmtJ5NoeYvuhKuELBKBCNrOJWrDoo55cGGpC6qxZtfBZnaLvue+an1/LTCXkFRmy9j7Ct5wJq9cAUAdM7rkkbsnhsKZJiKjWL6h7b53sFJPj+nSVzSEHxfIxEEivrxoSoKYzWLyMZf5Iu/L/4EnrKC4EgAJzBVOKRpswGF7RlhDkNLhBH/myGAfBuN+mFiSPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCnE+RYz/C58A3ZQ+9YN6PxGZ+F8lj3e0pAahhMInKg=;
 b=t7rJhCtkPnboecse0NEoL3cGgZls5oizbqmUJPzu7cs0uNqMXx1XOuYIz2P7x6kKKpIm41LRwSZ803ExOTeqVGRxoty6Po56uLAEAZjdpBT5G/5L4SVl2XAhrfV8gmR98QEouChQJCBPJO4dOXm6WNWEaSvcsqMTahtik4YRpSc=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by SN6PR11MB2720.namprd11.prod.outlook.com (2603:10b6:805:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 06:32:31 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::3d19:dba6:1424:44da]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::3d19:dba6:1424:44da%4]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 06:32:30 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <Horatiu.Vultur@microchip.com>
Subject: RE: [PATCH] pinctrl: ocelot: Fix for lan966x
Thread-Topic: [PATCH] pinctrl: ocelot: Fix for lan966x
Thread-Index: AQHYT2xgrw7CXd8+10e0lHE9OjwwDaz4YWvg
Date:   Wed, 20 Apr 2022 06:32:30 +0000
Message-ID: <CO1PR11MB4865F8C372AC4CD2E19CCAF792F59@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220413192918.3777234-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220413192918.3777234-1-horatiu.vultur@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132d1093-d668-4b26-1b8b-08da22978be3
x-ms-traffictypediagnostic: SN6PR11MB2720:EE_
x-microsoft-antispam-prvs: <SN6PR11MB272009A87EA1A83DD6FB16E292F59@SN6PR11MB2720.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtIQXRUimdYxKzkKLDv0mfrBpITHjlA1+U9ypRKG8er0xMrU67k60CjyXm863nTJ70pWZzmE/jMuW+ESeLcDMIndggsKD2m98eLgg/1B8nN08/P7yC4qhiEzBdwwYF8g9FNPtp+BX1g+I+jYhhOSe1IujGER0tQ4ObOXZAMkswdYJ8EKmItL3bR8gESeMr3aHGXBEJCyQygRiXnIHvBrzxjwivr5ViwQkHEwjA/3a43OgnmwTLzz0yQ4APTcUyv+CPw7sWWO41wbsYtAg3AOBS9oEAKNT/frNN8htquCm8Ynr0KNSb19+2xFr5v6Crjn14oQLqg6C2rFWhGfJbQWkFcgvGsREUjt/JCw8bHCxigmByUYfsCH9o4fNttqHfLzyT9j8/RtAjX7EVs3zMCeJapn9n7xHJqcHxIZue06HTc6fUkW4dgmeJRikij6v1gb6Rx/wL9L5i+bSCbqchX9lMzNHpOd0k0GOBRueU3Mt7lNw7YkqBCGfKYP/Dda9+u6GYh297B73j8fbHk5sRyOhqL5KLxn/UTA7li1ICqu8+jmuRsgskR4ipt4JIThkatRaFishi3o/sJssi/4l+RkH5GWOY044/9BD3tuAgjYz9sLKVK/S0rLbFdEPckXhqTwsNyJcPCV2ohRz+F7chpxCNJD1rNtIzwD6HmnTxhkI4cIvjA5jTVB3nRoAJ10KmsM4JNDnYMnwbxZyPzKTN6+/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(2906002)(6506007)(66946007)(508600001)(76116006)(316002)(4326008)(55016003)(54906003)(9686003)(66556008)(86362001)(66446008)(66476007)(64756008)(110136005)(8676002)(71200400001)(33656002)(83380400001)(26005)(186003)(38070700005)(5660300002)(8936002)(38100700002)(52536014)(107886003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OueL35n4MMX9xZmzKIL6nMlH+QzNAu2YdtWQSY2lepSkg53Zq4pqMOqZznKv?=
 =?us-ascii?Q?qxy2QDVV9Qv8QZWuPbQvV662an6JfnO1VsRiYxOcOp0BcqjQx5N78Ga3n82y?=
 =?us-ascii?Q?/T7rIJuJSUnQfXSvFc0Lc9Kboq/qY9RQEgJEdAZl2GtLijkPMnSvhC9iZxUQ?=
 =?us-ascii?Q?J4tWsyAQZmaK8ObFwvg/pt/W36EsB2GYQPfL04vtT4S52/I3qqGsOInLqwke?=
 =?us-ascii?Q?+iMhNghz6xBufQsdiefk0UCwxv4UsAAB7qHjShovVNX6RiesrbXqL01Oc6pB?=
 =?us-ascii?Q?Abu8YlUiLNeFfKFQjYW2E8uhlsxOtrz+Dg4LeIwcQ7PsTmv3l0qop7kpsTxd?=
 =?us-ascii?Q?QP6aD0NqrwOexlHgQC32iEEJAEL8Xv1vgz7EjhLwN/mB2i7pd+vzRDIAGC8z?=
 =?us-ascii?Q?EnrZA8np6vEmUNM4Q1Gss4o/hJ65QhJnJRnkN0kRLAO7g8JJl+ii523R/FML?=
 =?us-ascii?Q?zeiWl+G7LUjK0GCa5335IYwG2aIc6c5wSsRZph6UQMYsH/aDEzci9FcJ7dCa?=
 =?us-ascii?Q?wqV5eAQx9WUpfIuwPJGre2S9V4j4VgVdNrhOsXSfBfh153EjEPCuC1IrB7nw?=
 =?us-ascii?Q?TZdA+13JM1taEii0r5V+V/oCP9RiMO+1Z0dlm98ysy7YXcO1oDHibjn6UwWH?=
 =?us-ascii?Q?FKSqqzqqoznuaYeRsOswFgRh7mIacU9NP+zVlVk1i2MNMtCjDFc51JyC7rZ4?=
 =?us-ascii?Q?XVArkVd/5FKs3DozB5591159IQ9nhZNBVSnEXEnGBJrbijc/mz7cP5EJlrDK?=
 =?us-ascii?Q?9trPYezCGPzyPwcUwSSBGTlUNLvT3bDJ3gtbUdjhyWfey15Vf4QCuwalfhzj?=
 =?us-ascii?Q?J//wzrSdq8I+l5qVIcwW12rh554MQ+dWMAkSfNWTHtahGCyD6W+HRfNh6NO7?=
 =?us-ascii?Q?tdc3JKCjKCDI7HlTygUC8wKgCYOFHtYi0/O7SvWe5C6SNuMSvoyUcrnx2BXh?=
 =?us-ascii?Q?x9h/Wc0RD/f8C/oP2hmTH1UdMfrnK/Z+4MMWnUU9IT/EQFXo0/wbLsYivOXr?=
 =?us-ascii?Q?YGV648X+G/Lxfm4zKo6oWnZPOUBOtNUcKb9N+LDL8wPn5ewnMmJJA/fLqqos?=
 =?us-ascii?Q?DCMan5IzxVPmdY2VDgfU/zLi9JS7FEOFOpYPvwSXYp0q2AnPZjhcIqmbRXuh?=
 =?us-ascii?Q?CdRbNxyXu+zri7Vqc7I3Zd32IeBKhe4w/KZbzaQvRXvfSIOqYhhMDxXOgh+j?=
 =?us-ascii?Q?vs05p58AwuFF6q5jbHmkk8GmSwo2a3NLy2RYvmqaeQR2HL93dmJPUyoPmLb8?=
 =?us-ascii?Q?68SxQLwE3uRUA9v4e6pufBHfbJBUTIWEHX6s//D4J0Qsfx1fOnxcj2bEjY1P?=
 =?us-ascii?Q?CkYMXp85bVFB8z2NePvOQlCi0GyrzHwM8MdQirCV4HlmApNXdm8Rj6LEbOJo?=
 =?us-ascii?Q?fmVFpAdJezVQQT41owb/VbpAnIpqA3hvqHPTWm1j/Pnada/p3MWl6x/DDQYg?=
 =?us-ascii?Q?LD1oAF3gtBH78m9Q/BA5/XzhgzRdFJaxRW84HIitcOEi9UZnAwtxKpkBcSii?=
 =?us-ascii?Q?11amjj5ghJ3Bqqn9fBOBIWg3RzpIl0yF3Mvqt4dGnHbx3vlHT4piXUv43Pm/?=
 =?us-ascii?Q?Q6ygffuvAE6lw8ekcUXhZs+tDsOkp5dKoOBExyLV/KnTgwm0upnL88VKACT+?=
 =?us-ascii?Q?omj1DdEi5scDlpZVnTTGIKzgy3RRqiNcHr9ql7ED8vgb8w9WOZrbdiafYT5P?=
 =?us-ascii?Q?/I9Wiju5ALfe/0CVXgS4ZdWQSpLRtTvGmR0zX+TG538n98Kq0K7ElbnvfctZ?=
 =?us-ascii?Q?c/+c0ciQpd+u4SkeeYR7oIep+QJ7cgs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d1093-d668-4b26-1b8b-08da22978be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 06:32:30.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQZTpBEbvkBqIbvJRapAwTjkXys44IN/QtCSQhcc51rY5fW7wucxHVUbYdFZC7yyDLqgoW/qFLGAs+gtz+CnBt1SdArt9aBd0B1/oVXBkvV6YRqHHzYSwrsZztkPJT3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2720
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For lan966x, the GPIO 35 has the wrong function for alternate mode 2.
> The mode is not none but is PTP sync.
>=20
> Fixes: 531d6ab36571c2 ("pinctrl: ocelot: Extend support for lan966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-o=
celot.c
> index 51261f1231cc..40f76e4144e4 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -130,6 +130,7 @@ enum {
>  	FUNC_PTP1,
>  	FUNC_PTP2,
>  	FUNC_PTP3,
> +	FUNC_PTPSYNC_0,
>  	FUNC_PTPSYNC_1,
>  	FUNC_PTPSYNC_2,
>  	FUNC_PTPSYNC_3,
> @@ -253,6 +254,7 @@ static const char *const ocelot_function_names[] =3D =
{
>  	[FUNC_PTP1]		=3D "ptp1",
>  	[FUNC_PTP2]		=3D "ptp2",
>  	[FUNC_PTP3]		=3D "ptp3",
> +	[FUNC_PTPSYNC_0]	=3D "ptpsync_0",
>  	[FUNC_PTPSYNC_1]	=3D "ptpsync_1",
>  	[FUNC_PTPSYNC_2]	=3D "ptpsync_2",
>  	[FUNC_PTPSYNC_3]	=3D "ptpsync_3",
> @@ -984,7 +986,7 @@ LAN966X_P(31,   GPIO,   FC3_c,     CAN1,      NONE,
> OB_TRG,   RECO_b,      NON
>  LAN966X_P(32,   GPIO,   FC3_c,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,
> NONE,        R);
>  LAN966X_P(33,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,
> MIIM_b,        R);
>  LAN966X_P(34,   GPIO,   FC1_b,     NONE,   SGPIO_a,     NONE,  MIIM_Sa,
> MIIM_b,        R);
> -LAN966X_P(35,   GPIO,   FC1_b,     NONE,   SGPIO_a,   CAN0_b,     NONE,
> NONE,        R);
> +LAN966X_P(35,   GPIO,   FC1_b,  PTPSYNC_0, SGPIO_a,   CAN0_b,     NONE,
> NONE,        R);
>  LAN966X_P(36,   GPIO,    NONE,  PTPSYNC_1,    NONE,   CAN0_b,     NONE,
> NONE,        R);
>  LAN966X_P(37,   GPIO, FC_SHRD0, PTPSYNC_2, TWI_SLC_GATE_AD, NONE,
> NONE,      NONE,        R);
>  LAN966X_P(38,   GPIO,    NONE,  PTPSYNC_3,    NONE,     NONE,     NONE,
> NONE,        R);
> --
> 2.33.0

Thanks,
Kavya
