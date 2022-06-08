Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A56542931
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiFHIR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiFHIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:16:08 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A95375E54
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654674300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdwPkpZzctPvwE/o79T8GkqOfZXSdYfzXOj5EUKMvvU=;
        b=DiatrHaooWGWT1m+uA5X+DIeOLqp1V8xWdsaDrWF/ERgZkqz8GvamYJloCNEhFGoDHZv+B
        55RIulDIf2y8KV5sEySoTTR4VaiO1/nDc68PC5GorG0LW+Wod3Hcx+9LubT8/mD2vnlJkW
        DrWshnc9CMk6C0P0wcDaEJHLBQtaamE=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2170.outbound.protection.outlook.com [104.47.51.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-M-XjCMvVOvWx5iPBgtVZJw-1; Wed, 08 Jun 2022 09:44:59 +0200
X-MC-Unique: M-XjCMvVOvWx5iPBgtVZJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXDXgsNm+qtm8U/lEsq1GGg7RYV8ZZL00ULqVUDm9z/Dr5mgIsiSSWdfPvRM1LuMwbgulWCVm6m1MMnmArpdawtPayFT2d95RSfd3t/PrMy51+Wz3sVxiZK6VRAvp3cHL/w/b4DYVU3qZvpvs2kEWZyeGbh5m7T6wsBxdFiG7bAl0msM5h65oqy0o046gtHK/5pMSiEccly92mvCQqh9dwQSsvRbLEjH/ZJItt4uf4WLwe4pTEwxFhsGfK4rCtPjTqYniNDyUmJN+j0R5uarNJOxa/HNPNYEsTb4f/3Yb9wQvogSCGfTLVaiozRqbjfUuzFbur8n8nTEAg/PS/G+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdwPkpZzctPvwE/o79T8GkqOfZXSdYfzXOj5EUKMvvU=;
 b=YG0VyeMdOWMlCGEKhXPyACtoToIHS71jaFTQiH/SLtcEeuSQDKqqhuMwDwBc4Ws3JEkn+ghho5KB2raYzPoON+tkmEaD0X9GBPZvJ/DiyE1NU8BEo9L5zUwfyvFr0retUHXeW79+qPGuBISV7uE8yG3l2ESq8HSKjIyvSVjqzwzv7YK0s3emDB3hrO3oxnrx+OdgMDAX57GAUqxbRUuL0kLiCuB/LgEpHTI31xcaavMAQcGrqqMYC1YDjrsafCMAjLm6CDDjr6rJXhLmknJ4ugZT+V6uqo7pludOE4CW4+xUbN6vQ0DKiKXf8/gsEf6V9HWOIocQuJ//wxhm5/+NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwPkpZzctPvwE/o79T8GkqOfZXSdYfzXOj5EUKMvvU=;
 b=Fn9mzReFfSOQvK8ezyk/Uj/Laj1EwxWSyq7VN6p7npfSYBdvg3ynQVTyfqVtvtGCcsHXcTjzzfZf3cwLFfwLzlS6lbJffeR7aq/FEF+xnw4yVBcW06cHT7Pg38koacR9zN7hlazAfcN68U7082f/7vBI5XX7k2wjD9rFkS0a51l14MT8NyvsVhZZkXh22Fc51SwRnt7JSSfd9n8ah923f8WqdI7DW2rTp1gAn3/pjLjja8m21NBDPdtyW+ar/Occ33Sr+uFB7JJ1iKo1vCFe9XXr8FOBHyeh1u7aTwn4vNw5SHbsPhJvp2p3vLs/dR3yJxt4Pfbl4zcNvJixfIHKVg==
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com (2603:10a6:10:103::20)
 by HE1PR0401MB2555.eurprd04.prod.outlook.com (2603:10a6:3:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 07:44:57 +0000
Received: from DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::80f9:38c4:1d69:7886]) by DB8PR04MB6555.eurprd04.prod.outlook.com
 ([fe80::80f9:38c4:1d69:7886%6]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 07:44:56 +0000
From:   Martin Wilck <martin.wilck@suse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brian@purestorage.com" <brian@purestorage.com>
CC:     "krishna.kant@purestorage.com" <krishna.kant@purestorage.com>,
        "sconnor@purestorage.com" <sconnor@purestorage.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hare@suse.de" <hare@suse.de>, "mwilck@suse.de" <mwilck@suse.de>
Subject: Re: [PATCH] scsi_lib: Don't fail the path in ALUA transition state
Thread-Topic: [PATCH] scsi_lib: Don't fail the path in ALUA transition state
Thread-Index: AQHYewulLlwlhBouRUWghRhCtyQnOw==
Date:   Wed, 8 Jun 2022 07:44:56 +0000
Message-ID: <0f741edf62532dbccb25ac5b9fab5031fdbbcd67.camel@suse.com>
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
x-ms-office365-filtering-correlation-id: 000e04a4-39ab-401a-2ad3-08da4922c83a
x-ms-traffictypediagnostic: HE1PR0401MB2555:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB2555E28C343C5873088E35C4FCA49@HE1PR0401MB2555.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uJr0pbEEv0WWAPrSIraT5OHRNP+Gi8MsFzyEQGzlc+6JebAO/ZnRgm6yaN+r8CYbMw9IEM1ztZ7bNoWI9Pe/+2yYVy3reNFGriw/ssyPFgD75UJZJJB1uZnPvSwDUaRp4a0Vm7ORCL5wkRT5NrODjvE3Ox9K2OTgRlahGQqpiA6C95fmzJKIfcwkJf2dzy+oFpNUqlFq1zTDHiH7ABvZOrNKI0vRFxZKbbmBGFa3//NCwm45uVZlLozXSmw7GkHdhMXX6XaX7pW94kHe/ACo0jo2/Juzj/dOinQirpy09BcctFhU1gGTlTZHQX7cRU5/DHsNL+VAbzmrVP6xG3GZXD6F2meGtSkpP58zTBpi5ZvnIAWMdruEoQkSzFc6gzjhumJ24W3j04f+N4gHXB03DLzdPneBLLr8JJQFS9hbcxRk9l6VxmBoZ4+Eqwrj7cKenro0ZEWEDFqtYAJ+lKChUKK7FWDdPL2XzmIUQB2Iz58zSumU5Y3XbiuXz/UHBbZs97jDJJtsoFXtTgfjJOap3ql7Mv56izQChV6NUexYKLrUitiZjlopSuePRZ6xzOn1EYB+iZL2nqquGzLJQo4iHReDTGWp4SJgqg4qSEUU4CTrFvtxOT9fv9F3710UmGupzFRlmV1SyA5SLnRy+gxs8RBQNMPDhO4BC/WklTc5Fet4Kzp9wWJly+RFWqOKLWeehcvbvkAq9Z2xx7PtV/dZtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(6512007)(26005)(83380400001)(6506007)(36756003)(316002)(8676002)(66556008)(66476007)(66446008)(76116006)(66946007)(4326008)(64756008)(91956017)(54906003)(110136005)(5660300002)(6486002)(8936002)(508600001)(38100700002)(44832011)(71200400001)(38070700005)(86362001)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-15?Q?qMIxZhN1Hhx5iH9Zb2Vl1XtUlUqisC++LegBZZCIgQCtgSl7UkX3ivaT3?=
 =?iso-8859-15?Q?vZiVNN5ZeUmqTl1hJCtD8ckZbYHvncWPk/dK8mNVVTbl0ydqEXqTNrm1B?=
 =?iso-8859-15?Q?Ucwj22KfOwwDzOtjCoFiXcWNoYFDCBzhbYY4x/23v3+axL6b7bOZrF6ng?=
 =?iso-8859-15?Q?fgzshFKnIWX3W4ctrYh4xWbkGG5m4c4nrkYL/u9LxIs92riUF468NGaZ0?=
 =?iso-8859-15?Q?y+S7X94GDhLH6t+9pPYw4deUZ6micBDKLNhBZen5DEhOYzjv+qBljJCbg?=
 =?iso-8859-15?Q?CNWnt3RRN4sSDMjiZEzOPEc9zc9Abz+UD5rucUc1xuughB7phK1WA6EC6?=
 =?iso-8859-15?Q?julEqVXcjjimpRzIQWrahzyVFGI3NzPW4eah8c3bRMF90WpxWYXhNFb7f?=
 =?iso-8859-15?Q?d2sKz2VGb/o6g4j1qeclU1zbdyYK9XOX5bP6mpwX3L8E0uknKqWiRqfI6?=
 =?iso-8859-15?Q?TDJTBz+vGneKvh8KM12TgiEZ36JhlhDtn2yPDxJSshjeGoivEv7d9EW81?=
 =?iso-8859-15?Q?m5Spl4bqNQK5Zb5wuLW6Snc6AWNoqUJZ25woTyVf3MUth1yKlyp609inM?=
 =?iso-8859-15?Q?OMNXzkDQkPVF0scsOJWruMSb6YsI9JfQOhXArp+cm0nHzGQU64w9EKMXF?=
 =?iso-8859-15?Q?csVNZo7G587lLxxUGIA89srd41FfFIhXOmVq/te3lLdHWfMO2TL31M3Og?=
 =?iso-8859-15?Q?YVDog0N0gOKXs913xMiaMDrzaPt20oNRiFQocHs0cMGnVBGEshkbBPaID?=
 =?iso-8859-15?Q?4TEWwPTGbPiEbRPQoH3tSWLCna18eBojJC4fySXpy1TFFWQWeJYQnKWVX?=
 =?iso-8859-15?Q?NsTw2yHtb1j9Z9Z7v8qk6hl4qaiYdydE2UDXfuRUN+gGVXeLW2SN99xSM?=
 =?iso-8859-15?Q?J8msWGpAG+ARRjlYKGKrkgQZeGFelotg4BY1c4LKV2uOqg9RcZB9IQTys?=
 =?iso-8859-15?Q?5sp+CdCvvGclz3qZibvsj6/tWvPyRznK8Swqb3uULxeKKWivjZ7bmy6bZ?=
 =?iso-8859-15?Q?o/QhshxKMYjLY6xtgF6W0nzW/EGgQouIXyLoNRj4NViQ0F4XR+roOrk1F?=
 =?iso-8859-15?Q?lGAZ/kMOBWgiplalbWHM4IrRRZ+elm3P1JVO+bCbP15HZAb2DdHUoYdCt?=
 =?iso-8859-15?Q?fhNDDxZXpsL8oaGIufBhbPWmX8RXGcUBzKGo5wp1INJvecwgiALbGo87G?=
 =?iso-8859-15?Q?iwJ0EwprsrUFIqOHwW9aJP7OaXdXDD3kAkBL2DNWDbxqQZdVS0aderpPl?=
 =?iso-8859-15?Q?1f01T/zhdj3JzTCWifmuIXBlfqzxK3h5GBAn62CBHNPrQUjarDfKCXq2V?=
 =?iso-8859-15?Q?R3fPZ3V7KF+EtLgenI25abYZwm2UkcUojlT8VEzZjWp+KY2zR5tVzFXS8?=
 =?iso-8859-15?Q?m8syrcMrhSIDV8taoL3Zh/G8S4Japid7tGiQ2X0u2owldrn0omLElcJ05?=
 =?iso-8859-15?Q?tk9RhX1lq8JJ68zD9CX3mX813AJqsHvSetpjliO1LltysWnr7q3sEPh6f?=
 =?iso-8859-15?Q?xCkWkIoKXdtfYovGW3DYPh3XCsv4kXPqYIG0YlPt40VyCwKFmPwnQ+fCe?=
 =?iso-8859-15?Q?pT1xenb/ehQ6gHMMlk3IKfEf+RYNafRItQjzDmnE4Zfeqqj0K5Kydze1a?=
 =?iso-8859-15?Q?wzBacAFwlzWWH7fki2Gd9m1KUd9w7jkt/4XM3vlVa7IUwe3t0/jRhiNgW?=
 =?iso-8859-15?Q?6CWCezArbAcqUjMJ1DYDMjNdhwaU2yu3l26oFwcrADVD5/BBbXrX5ZRSc?=
 =?iso-8859-15?Q?BbjgsQkOfewU7zd+oLwJP1vN/Phooo+n8unTQCh2oJjeroY9n+kQ2pg9K?=
 =?iso-8859-15?Q?GvV8F4mbZ5RC7XIEh2q2eLePkGuD9vEPeNMxchb4DlpWQJqCbiB8ZRTEK?=
 =?iso-8859-15?Q?Y1po=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <E0693D740085B347A9E97DDA54A2FF67@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000e04a4-39ab-401a-2ad3-08da4922c83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 07:44:56.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkX2KioLqKza/xH+Sv1Z4XDmK5xmTMu4s/hKQi3R01fgFW1QLPj+Y97/rH2/3iqRJEG638sDqd1Pgra6exAGzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2555
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

Please explain how th (failing the path after the timeout) will come to
pass.

AFAICS, this means that commands will first be retried without delay
from the mid layer (NEEDS_RETRY / maybe_retry logic in Are you relying
scsi_decide_disposition()), until the retries are exhausted. After
that, they'll be requeued on the high layer, with a 1s delay and
retries reloaded. How do we make sure this doesn't go on forever?

Do you rely on alua_rtpg() setting the state to STANDBY and
alua_prep_fn() subsequently returning an error?

I believe this should at least be explained more clearly with comments.

Other than that, the patch looks good to me.

Regards
Martin


> Acked-by: Krishna Kant <krishna.kant@purestorage.com>
> Acked-by: Seamus Connor <sconnor@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>
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

