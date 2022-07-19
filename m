Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A531657A084
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiGSOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiGSOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:06:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95DC78DDA;
        Tue, 19 Jul 2022 06:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Kj8ZA5loqndFil3h3t+RJjN8US+d2oV18gZW2dS4ykM4qunrzP+yTsApZaryX+LjhkqjCNQ3TswJxJx/alAr5tkq/T9iBovS280R5YWer7tmcVd2sS03GZnBh94sqdc2CHj5RcQzm8cJOWm9PsdSV7yr9DA8OPXdbfedVaV3BS+OhwgVL0qV2LHUWepv/Z4dLALSrwiWR16I6LHdjwGhG5Z+2jOIg6U9mYEw85mnvGP1TolRl0Ou15JqpzD9yOgkT583eb7UKueg5ol+DnWrZvMfz8CIv4vOVw5fLyia3rgZGC8BuBMUJWCE2oUG0pzUPy0daT51Sob5OqJEYVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWwB5D+h3QcnGBQDi8/4I8BNFK2Vh8xCnoirJCTWAuU=;
 b=OT1DlFRLbkEMtosEQRXz114Px566WOxqVY434dsvn6PmDIh7PWHYVAu7e8qLMszBHQ6jPhCs6DkwN7MaoawZlzXY8HAz2Bie6Wd+SxwOF0MZ9IECox7fuHAIUhppYZFfOH6V7ddnOARXfbQ4dLb+IexZQzYEDljZj2EtfWfHAxbBmR4n4/npqZZE5jbYYPtEJhmP3upBb478bH0nkxZWRQ3Mtmb1P9IbDa7B2dg/yYGf2RwBc3G42HrE9lvBOzhbGmWVNMbHnULfZeFZ68ImWUXBeh7WFF4BgICTYj457GVvXnwuryFB3BryRJMn2yHP7kPnVjSyOoi2OhgP/6tANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWwB5D+h3QcnGBQDi8/4I8BNFK2Vh8xCnoirJCTWAuU=;
 b=mSSHEDNtjJSemzie/QjPRiQ2x62d5s4C8Btw3CwMlNi3wfiQPEjkVUACrIOdh5xojXHEqorqJbbrgB50TVXbWuUBiMghaNgHC3OTbDKLGrSl89plVoLgindhs7SeZqAfrrcga5arVVXs/zdsOwJUZ0XgsyKg+hf8QhRyohbbmUU=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 13:21:42 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::30c4:f356:a806:509a%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 13:21:42 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Topic: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Thread-Index: AQHYeZhXApErq+32kkmuJFVVfXogSAG7F8aMAeAoVR+snXQgIICishAAgCJ4JhCAAFqwgIAF7C1A
Date:   Tue, 19 Jul 2022 13:21:41 +0000
Message-ID: <BN7PR12MB280220006B18F06E9ADA31F5DC8F9@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YrRXTrYN3BuShbzg@sirena.org.uk>
 <DM6PR12MB28091BEB013B6F1903B5CDE3DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YtGNnT2cP5HIayp3@sirena.org.uk>
In-Reply-To: <YtGNnT2cP5HIayp3@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3211a7da-ead1-4143-ac94-08da69899eb1
x-ms-traffictypediagnostic: DM4PR12MB6566:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjJSmUt9/1VHqvCsE4B1U+1ZLdCx3qY/HcbUAxtTSWXurnlqWLvN6avBQGkLGZHF0prFGsDx0gEkBkeYq+zZ4/bt0kAuyczmZW4yHA8ZJE7e59SfaAlYfBikgsJXnaWPPlzyNWEXbHgs/cftQ4+b93WROFjla7uT6JlBiBsImKMzo/OtHeiDt0T3OtKccWq93hpNGGhs3B/R8Ae5ytsTf3Jqcf0zyKXHqz/W12WRlQRd7pA/qUSsDP3P5CWxqDb2diZqL99QJy1bYjbJNxf3BVSkD/nOsNaGtVJbZYm3dHaYgAJWVnSD4f+L+Q/fKlrt66tHNzDq3ibtaLXnDJi3oUnsfJZS432l/m8/oLub4t7fwFkVhr7DaHybCtjtE8HeoafoUS4A4+jmw6QPbu0bMp0zfvfWDvFAfh6jGugOHSDcq0h6BJ/uppjV1qFZBsTwip3CR157Cy3zcy0M2gf0SBAScIjnXaPZ2XIzYOomStWtQ/Y66cmWHYQeEpmvTbC8FbCEmQ8Dyosz3dJFnNMwAEx8V+U8yZIB1KFKwjakieyJvI3PW1wk7U5j7wSWjQSZYZmorq9jy/6yJ/cXXCyUinq8QTTbjxI9fMWGk7uuYQR35qJ77VjHw9dq6wcJUaj9yRWMiWgRkmZ4XfZ3WEUVSiCVBOjHst0HhbjZJcp1FJi8KDWvUz6ae/CEnwSzcdk9fhXeVYAKzf3jbHgkC2fEXtVINvVA2VKVNVF4euYm2jeZ+crtxh2JxCrngMpMoaTCkbSyom1Q9o8Ph8icfIRhrhg6Pr6bc2vLW6Vpv2lFSyNf5jYpvAfloJ4+dZlmkgXz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(5660300002)(7416002)(8936002)(52536014)(64756008)(8676002)(66946007)(76116006)(66476007)(66446008)(66556008)(4326008)(2906002)(55016003)(38100700002)(6506007)(26005)(122000001)(33656002)(41300700001)(7696005)(38070700005)(53546011)(86362001)(478600001)(6916009)(186003)(316002)(54906003)(71200400001)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ss2X/OV0NTpa4OVaU5uQvc51Kcd49urmcXVl5BUmd/Ry4UJ4Ucrwvtduzcvw?=
 =?us-ascii?Q?ir/KLjT1MuSvHi++t/XOEuhT/Su2OrqNxC1BRyJkal/mlo31DlRExBNixEYQ?=
 =?us-ascii?Q?qTLIZK3fZKu5hETzoDaMN33VMaMCIO8rhjY0SvkjMjT/8OgNAiTafb45635f?=
 =?us-ascii?Q?JqhcQI7eqn7J6+CldLeyTaku0GkkZtlq6W5xBvV8PE0ecHXfMQMACrxNo81j?=
 =?us-ascii?Q?En5bEQ4rD4VOUWEXRkrWaUZBQsNUTkzWKsEDTptjpD3n/O06b7KkxOht5RAt?=
 =?us-ascii?Q?DwZXl98UFmmVPYyjg1WO80R8LsAQnpO/0GJWQc2rCtBz5305XrXTRpvaJQTB?=
 =?us-ascii?Q?+CN224VhdXFdynMXrBrOCWzVTPADtMTfUlLtiPNi99oOy2OJnDaoK9k44c+4?=
 =?us-ascii?Q?cFA2hDFuNieX852tVv0f++DfXGY9qCoqpIFZGss1D5wbIvvlHYdsmRxOM/Pe?=
 =?us-ascii?Q?UUFI2T0BJ9wMhDyo3X3gX8urJQ+oowvjSBmo6ofZdiyxYWw0WccZNd8xo8ty?=
 =?us-ascii?Q?PeDCPfkYt1SGp/T0d3UKUc32pvIl+R0I3JRCk9o3TUQkUGHzM+HyBpresjlm?=
 =?us-ascii?Q?4z9weB/ITiGbiRKTCJhL8ZmeP86/orLjvnxAMklYg6E4anr/1kTR/YJqm3LJ?=
 =?us-ascii?Q?THo+yO14leDMnAw5MlbFuQgCeBFz03lNW2MuVJLWc8VT89Fcq19qFB7J6fNT?=
 =?us-ascii?Q?iJHfLLgE+qwdMNMzXpfikPPlfFoiOdIoGwEqXingyPye57NuJP00K45GTVfZ?=
 =?us-ascii?Q?BuatkRq/v1pvy6srcSiq6w9/HJ7o4Ur7DW7BUFYxby/3ZLOOaU1xRDq2gX5V?=
 =?us-ascii?Q?4+Iqyk5bL2h8v00rQRBatRh3rZ8JCpM0P2/Svkvkz2bebSbSj90T5A4IyO8y?=
 =?us-ascii?Q?sMZAphmz9yoCKMpVNYGZQ7GfhB1f6VSuxhs2JRSF2cdzJdo9FLZWbyt5PhN1?=
 =?us-ascii?Q?7BNRA0zH9bqago4cU3eypIp6KAgYZwYK+zaawTYPWZXgAeABz+eJ3ARn+6gT?=
 =?us-ascii?Q?iXT1zvJKF0K1K1NGXSnBW6/JdrFfzXisfalRLnFGkDniKTTsuDsKAWlfNL6A?=
 =?us-ascii?Q?phnRKmQp11vkpMTHLRNi5D3vVYrH/g3gJb9rJiZ/zJBgfMVNn8f8HTugl1zp?=
 =?us-ascii?Q?TQc64DHQR9pufkgUAB0eJ4b7tRDqUXykPM4/azlTXNRgalGJPjmHOq0mMMNb?=
 =?us-ascii?Q?lPjPYdOxvNwib+KHmJW6oEoAKCJ9yajaiP130IoEDPnHvPl82F4b52m2fB9a?=
 =?us-ascii?Q?ngnmy+JwQ0IkWgv+gMwgP+kEl5KUzgPUBICXmv7prRjT1iN5zAVPJZFnUljV?=
 =?us-ascii?Q?/XSwJqjV5FSbbWXxhIRHy6Zmm2mlTxfm8Qyjj308lu06VyOG6a6bu7qIRd1a?=
 =?us-ascii?Q?aYeVBsr9WX3YTR4l1giYbS0zHQ1BjUSI5jBSxvN/cSOjHEILTncHgiEBJq5w?=
 =?us-ascii?Q?3FT2c86sKLSgL2dOum733032QMgTaWwks3GxNi/XPKs/GmGk65XpecyFVzLf?=
 =?us-ascii?Q?oGZqHwLJq55bcMylo1hrog4v3ggWGkk6G51CFhNMQZkTIc3NZJQnpnwugrpr?=
 =?us-ascii?Q?0iiEEmCuk2R1kvZ+Cv8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3211a7da-ead1-4143-ac94-08da69899eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 13:21:41.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jvx9MhuhgxOIhMuH0Cg2AkvCLV5jyfmSQW/iskQgHDpZeFnoA1cINWpNFL6N9nY933hgK0fCdQ34btCaaYYL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, July 15, 2022 9:24 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>;
> p.yadav@ti.com; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; git@xilinx.com; michal.simek@xilinx.com; linux-
> spi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; michael@walle.cc; linux-mtd@lists.infradead.org;
> git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SP=
I
> device
>=20
> On Fri, Jul 15, 2022 at 03:35:49PM +0000, Mahapatra, Amit Kumar wrote:
>=20
> > > That doesn't address the issue, the issue is checking that the
> > > driver can support multiple chip selects.
>=20
> > To address this issue, in spi core we will check the number of items
> > in the "reg" property of the flash node(which is nothing but the
> > number of chip selects) against the "num-cs" property of the spi
> > controller(which is total number of chip selects supported by the
> > controller). If the number of items mentioned in the "reg" property is
> > greater than "num-cs" value then we error out.
>=20
> > For eg.,
>=20
> > rc =3D of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
> > 						SPI_CS_CNT_MAX);
> > if(rc > ctlr->num_chipselect) {
> > 	dev_err(&ctlr->dev, "%pOF has invalid 'reg' property (%d)\n",
> > 							nc, rc);
> > 	return -EINVAL;
> > }
>=20
> This would check that the controller has at least the number of chip sele=
cts
> specified but it would not check that the controller is actually capable =
of
> using more than one chip select at once. We should be validating both tha=
t

I agree, so for checking the controller multiple chip select capability(usi=
ng=20
more than one chip select at once) we can define a new spi controller DT=20
property like "multi-cs-cap"(please suggest a better name).=20
The controller that can support multiple chip selects should have this prop=
erty=20
in the spi controller DT node. The spi core will check ctlr->multi-cs-cap t=
o=20
operate multiple chip select in parallel.

> the chip selects are available and that the controller can do something u=
seful
> with them (and probably have an implementation in the core for doing so v=
ia
> GPIO).

Here are you referring to the usecase in which a controller implementing mu=
lti CS
support using GPIO? =20


Regards,
Amit
