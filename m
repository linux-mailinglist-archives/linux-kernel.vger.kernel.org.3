Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697B543A28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFHRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiFHRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:22:27 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9540407255
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654708434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBX5lQrtWexsOxUKmFBHaid75nm7c1EpIol33qEksbE=;
        b=gANeCg78GEvgGOV2+5ixjoScpsgXqcBlfPFJmmqiR2dKrv/zFG9okojQ8oqNotpsGQHRny
        Ydi0ZGI3bzGikYR1QR9qH1h/oep9gqroFLcz3l30yF4egIGud3ncMyiJOS5Tg7jhIbOXqr
        hEz1avu7jKknKnswCWyQyorJJu8F7HQ=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-qijkKEzEOcW9A_McpMF5pg-1; Wed, 08 Jun 2022 19:13:53 +0200
X-MC-Unique: qijkKEzEOcW9A_McpMF5pg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNHz6Ttqqz7sDe8RqD1kGgCtOKc3xRP8jt5k3GKpIBIB3iby9jbRbZ81htaU+E0RpR+SQ0im2pccX4plv3LEyDBhkhOK9Kz2mnygnPjE9ugGo6/d9Eiq/OzBJ2NHMNe42VlpzX2nfhRRx9zsoqJ8uW5G+V3UslEM9Akv0yw/MjjkwJjVczGXEUBggKoRjsIrHJetJAihD+dFrOnGa6vZb0xGpuuUnWdj+rtQeHFvqsOPDKPPdtrnjw6QNHzgVjp047dbZW9WtqazonLiIW1qH2zmvenrFFt/HY5jvO8k79rKQlQhBnTpZM0SvtGGFY0q0q0J6+9fZkxatQ0QeuqK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBX5lQrtWexsOxUKmFBHaid75nm7c1EpIol33qEksbE=;
 b=NlIMAl9KfjwzRke/34E5NK+wakN4a0WTTI9Buqc7ZfaOI9JQW5zasn58XeBcpySZY8zC+AAD5MrS3CSoqq9anfp4AdKCjqj0R5Ou7HGqml5VLiuzLRi9coinSmAS+gqVBaMvhsmKjY0nkQ9DX5GB9nN++3swv141L49ozS1YyE4+a4GzII2hm2VvVUeRM0ZoRdfvWVF4wzyVvA/2mMUH3tGRuktVuVohfoxZmX0V/1cS/phUlVUSn326FiIBFajcYTARQY+QEBU+R8AELY5EKhVtW/H1vqV+ZGpSoQ1yJS4xKlKndjpDubOD8AhlGy7Dg1dFeRZzm2KEMOXLBmDdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBX5lQrtWexsOxUKmFBHaid75nm7c1EpIol33qEksbE=;
 b=DPex4W8igom7zl11IzL4C/3kp0fed8LXkNrEAbtEa8h9l0J9nuXMLIoTM/1zpD7UqQ6fQNSi7VvAj7Xg0ORgC2WjyqiszOuNJi4vTsyr5uGm4mGznGyQ5B2UMFfxpHBJhrTWXWApv1MSj30Ykc0qq/kgM7T9I7aiXlUjpebseBb25FZ+wulWPDzubFXeZGoHjAImkYmQraUumHkuQuuEfroQP1k940i985mHk8FKZyBUVtImZohBnVlQR4AGdPzGgz9BNjH2Ul+cII13ADBMBf0hWMD8i1Fyz7RQvUqFsd6TAqoGcyUhYWbNFHlOuYWV577EaL6AT5QhDUiBSIJD/A==
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by AS8PR04MB9048.eurprd04.prod.outlook.com (2603:10a6:20b:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 17:13:51 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::80f9:38c4:1d69:7886]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::80f9:38c4:1d69:7886%6]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 17:13:51 +0000
From:   Martin Wilck <martin.wilck@suse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brian@purestorage.com" <brian@purestorage.com>
CC:     "krishna.kant@purestorage.com" <krishna.kant@purestorage.com>,
        "sconnor@purestorage.com" <sconnor@purestorage.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hare@suse.de" <hare@suse.de>, "mwilck@suse.de" <mwilck@suse.de>
Subject: Re: [PATCH] scsi_lib: Don't fail the path in ALUA transition state
Thread-Topic: [PATCH] scsi_lib: Don't fail the path in ALUA transition state
Thread-Index: AQHYe1sfwymmLN8NMUyPKNpnwN1BWA==
Date:   Wed, 8 Jun 2022 17:13:51 +0000
Message-ID: <773e57f47ecfe98d2a89fb0611696a754c55505f.camel@suse.com>
References: <20220607195800.43485-1-brian@purestorage.com>
In-Reply-To: <20220607195800.43485-1-brian@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4d9df04-09d2-43ca-610f-08da49724272
x-ms-traffictypediagnostic: AS8PR04MB9048:EE_
x-microsoft-antispam-prvs: <AS8PR04MB90485B89B6FF8851EE60F353FCA49@AS8PR04MB9048.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SqlT//jj+a4JOpyoqQAaWR7IBt+sdTwakHzmlFKfurt8t5WiWKbFZbT1L1oI/lKoM2DK0tkN9LNfrrZmSnWSVKlW6O1vRjpsuM9VLIo7U8uR26ofohfj6CpkJ/0C54CSICoYfvf3DlroxmULCpfhW2OImgTtMsjJHqJ2vin6zjnkCvVhO49yDA7+9KAe3DcxfBgjtwpTDaS/lJXsej4SD11lwFahQkN1KCuZkBIP73qN0oCLcXSIkMvO9oFWeyshD4b70BCKY4OYughJGKe1afR4a0Ez/9QeoXb5cVx4brt0XQ3Jkm4MrVGi20F/5juMukRhXBvsoxmERU2LO5WA6HEvSDoPLyLetF5YQ9oG3WBanbaHYUlD3GmZszjtrAKTTYiykyVVr5tVJfQ1jJklJZl1R0M6Gpg4DdBGaRJeY2L5gp9egYaYKUe5N/Vh/5cdoenjKfxPKhFbVNCc/rnKpEjrCJLNJISmdZV5Ps3CXqJEYQUH0C8JO4P9mZoVm5+5astjtqTKuiOoreWwBYaUa+6U/hkjmt5Q8ZnJiSDT9DTM4l/Z1uVLNcdtRCwQxHbAi9y2WaXIYU83zxd7uR/AumYD9/1UhDua+Kvd9pcDQJvP7NEqmfFZUC4XcBHaVeMT9vM/Tev+mEdI1F1mgaTFA854EnLBGBZzJbXC2C0JCEhV8NjOoDP6Qgn7rIGw8uYlCt38g8mUv35lGlrgnzAVBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(316002)(2616005)(36756003)(6506007)(8936002)(91956017)(66446008)(66476007)(76116006)(4326008)(64756008)(66556008)(38070700005)(86362001)(6512007)(38100700002)(66946007)(6486002)(122000001)(508600001)(8676002)(54906003)(71200400001)(44832011)(2906002)(83380400001)(5660300002)(186003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?TNJtw8qvL2j/p4SmIdJ4//AJ0CNqXAgUljTvA+4KBiFtPxzhv57cu44ke?=
 =?iso-8859-15?Q?LbfLAytwfyW2WPfQEPXa5a7U+/4Ho3tYILliSls50O7UNYTsLGHYUKELs?=
 =?iso-8859-15?Q?f1HRZslaegTSjbj1WHxI1McgKA7ZvXJ/cZWdFUynrRma00Y5FdRzk6A6F?=
 =?iso-8859-15?Q?g5Tup9Oe8MVvUu3sOBsxLkPFOuy7MEbIV1baIlkFp+0bM5dt2vRhBRCzO?=
 =?iso-8859-15?Q?TdaDEdaifz+pwSt8ZmHbBoE99gk0GWES7hdXTZOGDm21ItZMaexFNndPT?=
 =?iso-8859-15?Q?mTjcYeZH+jBdbDbuw9SjHfUe6Cl/z3WKLP2eSJGtfg1JAe7hX/CoXeApj?=
 =?iso-8859-15?Q?z3GDv2RaYxNms9RCTsTn0dep1Mq9UtsGVtdd+o1eH8wNfQq094IeMIH4+?=
 =?iso-8859-15?Q?MhFYH3NMgroonEV+K+NvaP5Jm8DLWyewUznmkYBRCV/4T/GHxOoRnqONj?=
 =?iso-8859-15?Q?k7uBQmaccs5xtTpq/1Z7inn+LFMSke0VXchLvJBU5V6hWUJauj/A2aCEs?=
 =?iso-8859-15?Q?t7sUn2GsS5IUgWyOn1eKVyCSs3CepljN3BKuZat8U0Su1qV9pnP60A5kQ?=
 =?iso-8859-15?Q?7U3YREFtl3j0QHbryuiZvToUUBWSNMLpFCHqilM7bHg7vU4NBChSlcaNM?=
 =?iso-8859-15?Q?vcsb5gC6dGrfscgyNE4dv2mRTVlrPJl1ZcWM8XOJeOkZjOZ646pxE3Ang?=
 =?iso-8859-15?Q?HB3OjAYd3knREu1w/6y/43TAT/j8/KYnG1nGnTVFGryjmKwDVdYRjSMsN?=
 =?iso-8859-15?Q?kP6OL9H/xDnJxaY8qwKb8C/GTltzA0HcBOxH8VwGMHD0mapQcuCG562Hs?=
 =?iso-8859-15?Q?etxrjPoGudMe5q5mOw3ewdvR3PKm/ejmlgXGEb4CM9Bw2TqQiM5+PNanL?=
 =?iso-8859-15?Q?zSNjnGaR5JXowgS/YFJdAXNyDuL3hIFIUKDCfhosPUIXN/CQAAsk/1N7Q?=
 =?iso-8859-15?Q?yGrCTsg/vDVW5bgKndcaTaCWCdzuhHPQAcr0Mv/JZNFV3TOoVd5cqsTeT?=
 =?iso-8859-15?Q?3GPuy5mehAZb07g+fwFwOxw1ctCrfPcpy1I+JZ88P7DErn3jRMuelpJio?=
 =?iso-8859-15?Q?hhqV6IHXpgdOwxn74q1igG+PP08wSxUn2c+GrpVzPl4koyKqYMGsxl+H4?=
 =?iso-8859-15?Q?i/LoRqY0zZsxFeiSX8PDu6hcXTz7Ow46BXAAi4nAvZo41hMKthhNGufnP?=
 =?iso-8859-15?Q?6Go3hZZLKEvEQ2efSoTiodlSMpOVv3aqBJljxeKNaqZHDR7XC4alvVMHG?=
 =?iso-8859-15?Q?glXPU/5dSIBTbg4FvJE679rntMf4aum60oKyWjP2Hl+w2PJh/4eIs1ne2?=
 =?iso-8859-15?Q?YPTSmObCCpuW79eXKoD5YlqReeiU38s/kt1tm9frKvAHTye6hZjtqvoI5?=
 =?iso-8859-15?Q?WNHD0T0+1/A3hJM6vHWAeSypzLZGET3LjqlflbJOzSl9iDRi0okQzhGkU?=
 =?iso-8859-15?Q?efw8V8XqrWgyTFnmEGujiRUATKTN3iMxBUERDdvDiSD/98bxvcfuhLNIm?=
 =?iso-8859-15?Q?zUJ+4o6odv4RN+RjxDDQ1GModcryXM1KYk6b5oF8CJcqHcE8BIQWVjO0L?=
 =?iso-8859-15?Q?1oDUtTeRw8UCNy/FnMib9UnYV6hwuLc5xjXM9yetaIc9QTlLN0vbttHZL?=
 =?iso-8859-15?Q?wQJ1l8jH3pieh+H6yAlX95aCvv6UHTDmGgvj/CPitGrUp8h6m7n0H9gxz?=
 =?iso-8859-15?Q?JnqovvB0/R7q1UWTkSXBOl2KF515zzWEu2kSeWsIZqBqNioHMaUUbjj8C?=
 =?iso-8859-15?Q?sW7CYpQz5L2tgGkl5aXAObFYslZv3z+u1mNlqYHszsELi8iJed1kS/XOz?=
 =?iso-8859-15?Q?dRZ6dFxrcL2KIGbcS7ouQ3Wuh4Q6KxxVOiLStEwzkgvvvVVgi8RtDlkBS?=
 =?iso-8859-15?Q?EV1c=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <5E9285D63F1FE84AB329A7D09C9C1592@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d9df04-09d2-43ca-610f-08da49724272
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 17:13:51.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YgYLjcROrYhJDC9IoHaLmT7EIXXg8g1v8P4O6D2KtwkOeUXfOgocPKMA2Ll4mfO2phqpV7MRrVC14y9CxLpiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 12:58 -0700, Brian Bunker wrote:
> The error path for the SCSI check condition of not ready, target in
> ALUA state transition, will result in the failure of that path after
> the retries are exhausted. In most cases that is well ahead of the
> transition timeout established in the SCSI ALUA device handler.
>=20
> Instead, reprep the command and re-add it to the queue after a 1
> second
> delay. This will allow the handler to take care of the timeout and
> only fail the path in the transition state if the target has exceeded
> the transition timeout (default 60 seconds).
>=20
> Acked-by: Krishna Kant <krishna.kant@purestorage.com>
> Acked-by: Seamus Connor <sconnor@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>

Reviewed-by: Martin Wilck <mwilck@suse.com>

> ---
> =A0drivers/scsi/scsi_lib.c | 44 +++++++++++++++++++++++----------------
> --
> =A01 file changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 6ffc9e4258a8..1afb267ff9a2 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -118,7 +118,7 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int
> reason)
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0}
> =A0
> -static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
> +static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd, unsigned long
> msecs)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct request *rq =3D scsi_cmd_to_rq(cmd);
> =A0
> @@ -128,7 +128,12 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd
> *cmd)
> =A0=A0=A0=A0=A0=A0=A0=A0} else {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0WARN_ON_ONCE(true);
> =A0=A0=A0=A0=A0=A0=A0=A0}
> -=A0=A0=A0=A0=A0=A0=A0blk_mq_requeue_request(rq, true);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (msecs) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk_mq_requeue_request(rq, =
false);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk_mq_delay_kick_requeue_l=
ist(rq->q, msecs);
> +=A0=A0=A0=A0=A0=A0=A0} else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk_mq_requeue_request(rq, =
true);
> =A0}
> =A0
> =A0/**
> @@ -658,14 +663,6 @@ static unsigned int scsi_rq_err_bytes(const
> struct request *rq)
> =A0=A0=A0=A0=A0=A0=A0=A0return bytes;
> =A0}
> =A0
> -/* Helper for scsi_io_completion() when "reprep" action required. */
> -static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct request_queue *q)
> -{
> -=A0=A0=A0=A0=A0=A0=A0/* A new command will be prepared and issued. */
> -=A0=A0=A0=A0=A0=A0=A0scsi_mq_requeue_cmd(cmd);
> -}
> -
> =A0static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct request *req =3D scsi_cmd_to_rq(cmd);
> @@ -683,14 +680,21 @@ static bool scsi_cmd_runtime_exceeced(struct
> scsi_cmnd *cmd)
> =A0=A0=A0=A0=A0=A0=A0=A0return false;
> =A0}
> =A0
> +/*
> + * When ALUA transition state is returned, reprep the cmd to
> + * use the ALUA handlers transition timeout. Delay the reprep
> + * 1 sec to avoid aggressive retries of the target in that
> + * state.
> + */
> +#define ALUA_TRANSITION_REPREP_DELAY=A0=A0=A01000
> +
> =A0/* Helper for scsi_io_completion() when special action required. */
> =A0static void scsi_io_completion_action(struct scsi_cmnd *cmd, int
> result)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0struct request_queue *q =3D cmd->device->request_qu=
eue;
> =A0=A0=A0=A0=A0=A0=A0=A0struct request *req =3D scsi_cmd_to_rq(cmd);
> =A0=A0=A0=A0=A0=A0=A0=A0int level =3D 0;
> -=A0=A0=A0=A0=A0=A0=A0enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ACTION_DELAYED_RETRY} action;
> +=A0=A0=A0=A0=A0=A0=A0enum {ACTION_FAIL, ACTION_REPREP, ACTION_DELAYED_RE=
PREP,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ACTION_RETRY, ACTION_DELAYED_RETRY}=
 action;
> =A0=A0=A0=A0=A0=A0=A0=A0struct scsi_sense_hdr sshdr;
> =A0=A0=A0=A0=A0=A0=A0=A0bool sense_valid;
> =A0=A0=A0=A0=A0=A0=A0=A0bool sense_current =3D true;=A0=A0=A0=A0=A0 /* fa=
lse implies "deferred
> sense" */
> @@ -779,8 +783,8 @@ static void scsi_io_completion_action(struct
> scsi_cmnd *cmd, int result)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0action =3D
> ACTION_DELAYED_RETRY;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0case 0x0a: /* ALUA state transition
> */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk_stat =3D BLK_STS_TRANSPORT=
;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fallthrough;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0action =3D
> ACTION_DELAYED_REPREP;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0default:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0action =3D ACTION_FAIL;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> @@ -839,7 +843,10 @@ static void scsi_io_completion_action(struct
> scsi_cmnd *cmd, int result)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fallthrough;
> =A0=A0=A0=A0=A0=A0=A0=A0case ACTION_REPREP:
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_io_completion_reprep(c=
md, q);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_mq_requeue_cmd(cmd, 0)=
;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> +=A0=A0=A0=A0=A0=A0=A0case ACTION_DELAYED_REPREP:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_mq_requeue_cmd(cmd,
> ALUA_TRANSITION_REPREP_DELAY);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> =A0=A0=A0=A0=A0=A0=A0=A0case ACTION_RETRY:
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Retry the same command=
 immediately */
> @@ -933,7 +940,7 @@ static int scsi_io_completion_nz_result(struct
> scsi_cmnd *cmd, int result,
> =A0 * command block will be released and the queue function will be
> goosed. If we
> =A0 * are not done then we have to figure out what to do next:
> =A0 *
> - *=A0=A0 a) We can call scsi_io_completion_reprep().=A0 The request will
> be
> + *=A0=A0 a) We can call scsi_mq_requeue_cmd().=A0 The request will be
> =A0 *=A0=A0=A0=A0=A0unprepared and put back on the queue.=A0 Then a new c=
ommand
> will
> =A0 *=A0=A0=A0=A0=A0be created for it.=A0 This should be used if we made =
forward
> =A0 *=A0=A0=A0=A0=A0progress, or if we want to switch from READ(10) to RE=
AD(6)
> for
> @@ -949,7 +956,6 @@ static int scsi_io_completion_nz_result(struct
> scsi_cmnd *cmd, int result,
> =A0void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int
> good_bytes)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0int result =3D cmd->result;
> -=A0=A0=A0=A0=A0=A0=A0struct request_queue *q =3D cmd->device->request_qu=
eue;
> =A0=A0=A0=A0=A0=A0=A0=A0struct request *req =3D scsi_cmd_to_rq(cmd);
> =A0=A0=A0=A0=A0=A0=A0=A0blk_status_t blk_stat =3D BLK_STS_OK;
> =A0
> @@ -986,7 +992,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd,
> unsigned int good_bytes)
> =A0=A0=A0=A0=A0=A0=A0=A0 * request just queue the command up again.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> =A0=A0=A0=A0=A0=A0=A0=A0if (likely(result =3D=3D 0))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_io_completion_reprep(c=
md, q);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_mq_requeue_cmd(cmd, 0)=
;
> =A0=A0=A0=A0=A0=A0=A0=A0else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0scsi_io_completion_action=
(cmd, result);
> =A0}

