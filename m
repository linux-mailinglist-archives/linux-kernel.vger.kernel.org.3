Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782A5554DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376724AbiFVToU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiFVToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:44:15 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20079.outbound.protection.outlook.com [40.107.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4E23149;
        Wed, 22 Jun 2022 12:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPkPcQmCQ/AoYq3fLVkU0tSh0JbU9dcVvrNq76o46vAYrktvvbCIngic3f09nO2K0vibMEHsIbMcezDLukayQp9RUpI7CwuvbMxK5tP7dbOISNAcA6BGFQsx0tqXuCGxZnWU24OoC4Mutx8YlsMZbmiOexle1L1KvdtXXM2Z2gnuoURxdzowNUeBhQOTeN5d+kBHCWPHh/fOvRejmadrfDRqC3Ol8txN6rlnZQLNQbz+fizCAvzxiwbe0cRPSGy8oBabbGA7rG/KCHJf0oUTeUPsToWrZD/uMXVX6vhu2RelFJyKz/+WushAiZBQZl62T2rB5cemMdv+iNs238RGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoY3F0a+Bqxu+LDc1jjJINfpttI6mQxBVvX9xLhK0NI=;
 b=fLGkW+Hij2AC/PVRxZv155b5tGnvlmDFitJrO0B2G2QDB+5lhFFPfMn40qmDo3sPAH9XWl0WFTgZVOyu5tMAHmR1i93QbH+J2N5tOhyX6uChdmqd/mmBeoYOimlVbCGpkbyWbCR1QwrNpRkllvXBqZa9//kYB3nE2LP3ZuwAO8r1Mac84hH7lLIEaRaNlj2BxtGPV64Bbnsm/QrksXIgZsyUx/b5OmiF74aH6x6pVI1SZ+cG87Ko4d46vm4qikcUSn23RVqQV431DN25sIfuNP/rxO5UYO1dbtXeHtn9CmSG0uB29DpcBoixO+//4AlLXFa0/U/PYrEVrMHq9nSWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoY3F0a+Bqxu+LDc1jjJINfpttI6mQxBVvX9xLhK0NI=;
 b=DGM6c99O4bf0ENsojb4PUIazEefs5PsN0h3BfFsvNBIH9mLU/yehBwsLJt9eZjZquay8ftqFj1eMoM2f2/a73YFgfagNgEIe9a5XCVBgOUdBE/rmvFnzhwL+snwtkulxm2/4inls0CjY+f62+ryMV6C+4/iCXGecdFrXCwyaZBs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 19:44:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 19:44:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Topic: [PATCH V5 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Index: AQHYgGarCm9RA61pbUCfdvVoyqslW61buVWAgAAkCkA=
Date:   Wed, 22 Jun 2022 19:44:08 +0000
Message-ID: <DU0PR04MB941734D3AE30D57EBE0C71D888B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220615032048.465486-1-peng.fan@oss.nxp.com>
 <20220615032048.465486-3-peng.fan@oss.nxp.com>
 <20220622172529.GC1606016@p14s>
In-Reply-To: <20220622172529.GC1606016@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c66f832-5c09-4e88-4990-08da548792a7
x-ms-traffictypediagnostic: AM8PR04MB7297:EE_
x-microsoft-antispam-prvs: <AM8PR04MB7297312982F2D704AA2AF2D088B29@AM8PR04MB7297.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgTxBH77rE3BSo1Eb+rf8nUqktTfUXa417Vo1aI6l4P9KWZpHPsQ80cgUzLTdy7/KeZCa3iGY0wYMEcrINFoH/RoEwztbGXwNM7V7tjnJZiogXuh6adSpeQcR3JzBym/uJWugw0cnYYQ8kKaJkEWVi9giNw4GTHTpySvbusIAaaqXPtf1Mx8Hufn/GGeClPmBE71CYsUcUheWgCD1ygo/dKe0U6TvFGKcNPzlRtRwDIkihu4j82+RwvQAMH5OPj7GrdN4UIXduPzPDW0wTuuApd2Ue7RbiABASLRb+9kuf1dbqoM5jelYJLGeM0PUTZX4hscM2ydF+ogc3L2HKCPlV9vGDE8fP4vvoE48/BtXVYg1towI4XeXooo/xGX4LxytVUo5hNRRHFMUZEAKTeMjQjI09fnBENEMgJo7ycLqpvPp5elnmEBfvHqGi1QVs5NMuJ/klTyy3ixpH0bW8Hbb4B1m7s83Mx4YfoblPdPIsMdnLosO914NnwPz5NbzjZRyBeA5+jbXdWzrds6uz5EeSYomqgAnIpuw63J62Xn/rn6ZJRnHNMGXsUt4M/dXhJnGJHNlg8wVM6lko3tvWuUswZ+Zbhe+xgu9709izp7UfxfhAMRNXH1rovr8GvnnCV0uKFZS4IAILrEdwt5CMQtpTdH5QMTBE4qc8MDcSn5uBvDsaG2koahpOrSjuHdkhn9lBMl4OM8at+HoQGSiWjyR3VhL0wSD1z96RHFEkUJjOcVhHHFxpYhBAKOXt14bSfA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(8936002)(316002)(8676002)(64756008)(66556008)(66476007)(83380400001)(33656002)(66946007)(4326008)(66446008)(76116006)(52536014)(7696005)(5660300002)(110136005)(71200400001)(478600001)(54906003)(55016003)(44832011)(2906002)(38070700005)(86362001)(41300700001)(9686003)(186003)(122000001)(26005)(6506007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKtDXIIvX2r4qJDFCRFZ6H9XOOzrlgzYV/0mL0DT/AKx8V53zP8ADa7f0Cxo?=
 =?us-ascii?Q?2wzpmusnfyP/6827CO6n7PH70yjHaEnImMp0aUOnsbN0R63AujVBIU3kLqKx?=
 =?us-ascii?Q?ksaTnVZ54y3AQnjnvfHJ74gQT4ohyQyIv5pQ8zhXN9wRET8q+SLC+Hpcd0a9?=
 =?us-ascii?Q?SbNWT5ahjWOuvJni1oE/Xbv7kmKrofyJCKWPZ7FgWxAv4it3Xg6jHVFCAdaS?=
 =?us-ascii?Q?NdRZP35ipLRIseN5qSGg0sVRaTg6IG0e3W82ykzqhY7/GegMzBQP38ZjhVEE?=
 =?us-ascii?Q?pWGB+LTZC8J30mnxVPT/c3qXGb3x8MOhTz3YE++W6u28Onsuh7q4eN8CKD8I?=
 =?us-ascii?Q?z+I0QgKqHXigl2m2uQKgForUHBta7iQJ8eNMiwcwJA/pdyC0PVcCOKUZUk+Q?=
 =?us-ascii?Q?D8hDDV1QNjlfQBAoueXOC9TCwOzOSpYgnWKFqahooQZo1+ZDYwacplXn2tu0?=
 =?us-ascii?Q?xSAm3qFN1xJ8mDV754fRZ2Vj3ilFZzrqypYZR9JsIHZWoCVLEXEdlg1+e0kC?=
 =?us-ascii?Q?KvjL9Pkhb3YRH5Wu7/DBP6IqzJD00bPNQ5lwizZAarqULBalSS5FaxlgE2cL?=
 =?us-ascii?Q?dbATv4srFbcrTg8+/KoRXaUSfT4oZFJjrG1yUh6n7kOKbZkQ+wKTq6+cwd2E?=
 =?us-ascii?Q?2yjDXz0OxXJGy5jR31VdcOvtbx045w2F3BxINpxKd5wA+ilSZ405tVm2SDKc?=
 =?us-ascii?Q?TGf+67hnNOmGbh36bRMh8mzandgbZ47GviYBSurO37dos5R/IcCNL4bomZGL?=
 =?us-ascii?Q?ya3B7CniGevARAZg/P4FgWhul8zkJb5o0nbuYcv/WphYGK0eR6jc+ehlIyuU?=
 =?us-ascii?Q?+VuNiiamDSMyUijjcEX8OmPBcrByo6eHyd0XyvwQlQ7Zlv3P6EYczSIm+SdH?=
 =?us-ascii?Q?Ii1rGrXwAYqePS9dJMonoVqsS31FvkOKiuSX3rnpR3f6EQC9rOgl+l9+4k34?=
 =?us-ascii?Q?40coFmfUbOm5r51QzqqreTQxmJ3gU6wFgHXpL3mnHhd+P0xCEuMdmpjU0NvA?=
 =?us-ascii?Q?H/TQ6HGrbx+/7rd5+sjH5S0EgkBqWTAEx4eTdqC3F4eFZXE6OsKqq/1lggtl?=
 =?us-ascii?Q?NXyhbmcRjAg0FYvC58M73VJOWmzPMCsrNBa+err6JLSq/UOVsJqVe1dySrwv?=
 =?us-ascii?Q?wwenThOtO5N65gYN8pv+i0c3VcGvqOhoe3AqTQGQapqXtQVQ3AzNLZPt5/Cs?=
 =?us-ascii?Q?JxaTCm0oV8QM3N61rsbqorIBTWMF02zl3dX85pBsxVx8zL8rZj0nHV1ty9ge?=
 =?us-ascii?Q?hl/Yv8idxLV60FbUl64gSBKihUrNioqb3fzLGaBFoeQTgFhRPgsy7XBizQq4?=
 =?us-ascii?Q?MqCERcYwC/DTD1UbPClZZi5t//LF3wk2vWqrGj8pDQUB4bHbQ1NEszjMEbS+?=
 =?us-ascii?Q?ijklUV/u6f/0uE4x9+OkxnwyfodFFYmuyqIW3pnX4/lb3NE+LUFcIJkiH25R?=
 =?us-ascii?Q?P/bfc7qwZWcKUrCOTiSO3+gqd53f5a9XeKkUAS0HurmG6o1tcjkTac4DePjb?=
 =?us-ascii?Q?1eSNCVhb7fKs5N4Ewfq8LCc0SZcm4nbplg3sqyOso5558VDuWsBUU+qojrn/?=
 =?us-ascii?Q?P/wWf+lnXICDhUvPYG2SeZZbTvnryNv3a/FGEdjOO2TmYHoPsQ+/LDXLwazK?=
 =?us-ascii?Q?Qf7omxK1l/Qt8D1E3khNg7okcHjZdBP4hnxJeQWV4IiYu8kJMIy9/RdbSgD9?=
 =?us-ascii?Q?SvbL5uMLYtMOAyavG7mfz9ULozkxSJBdrW+kxYA7aE0hRkQQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c66f832-5c09-4e88-4990-08da548792a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 19:44:08.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjpmXmjlYRMgPTEggCRlMHtwiSDumHVAbB9EdE1dMzWQ49yNb5ZNyOCJaHdCv3Wf4HIDuhM1cuhqdUOkXkk8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH V5 2/2] remoteproc: support attach recovery after rpr=
oc
> crash
>=20
> On Wed, Jun 15, 2022 at 11:20:48AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after rproc crash. However to SoC, such as i.MX8QM/QXP, the
> > remote processor could do attach recovery after crash and trigger
> > watchdog reboot. It does not need main processor to load image, or
> > stop/start M4 core.
> >
> > Introduce two functions: rproc_attach_recovery,
> > rproc_firmware_recovery for the two cases. Firmware recovery is as
> > before, let main processor to help recovery, while attach recovery is r=
ecover
> itself withou help.
> > To attach recovery, we only do detach and attach.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 64
> > +++++++++++++++++++---------
> >  1 file changed, 45 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 02a04ab34a23..1c1c90176aff 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1883,6 +1883,47 @@ static int __rproc_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> >
> > +static int rproc_attach_recovery(struct rproc *rproc) {
> > +	int ret;
> > +
> > +	mutex_unlock(&rproc->lock);
> > +	ret =3D __rproc_detach(rproc);
> > +	mutex_lock(&rproc->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return __rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_firmware_recovery(struct rproc *rproc)
>=20
> s/rproc_firmware_recovery/rproc_boot_recovery
>=20
> > +{
> > +	const struct firmware *firmware_p;
> > +	struct device *dev =3D &rproc->dev;
> > +	int ret;
> > +
> > +	ret =3D rproc_stop(rproc, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* generate coredump */
> > +	rproc->ops->coredump(rproc);
> > +
> > +	/* load firmware */
> > +	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "request_firmware failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* boot the remote processor up again */
> > +	ret =3D rproc_start(rproc, firmware_p);
> > +
> > +	release_firmware(firmware_p);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * rproc_trigger_recovery() - recover a remoteproc
> >   * @rproc: the remote processor
> > @@ -1897,7 +1938,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -	const struct firmware *firmware_p;
> >  	struct device *dev =3D &rproc->dev;
> >  	int ret;
> >
> > @@ -1911,24 +1951,10 @@ int rproc_trigger_recovery(struct rproc
> > *rproc)
> >
> >  	dev_err(dev, "recovering %s\n", rproc->name);
> >
> > -	ret =3D rproc_stop(rproc, true);
> > -	if (ret)
> > -		goto unlock_mutex;
> > -
> > -	/* generate coredump */
> > -	rproc->ops->coredump(rproc);
> > -
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > -	}
> > -
> > -	/* boot the remote processor up again */
> > -	ret =3D rproc_start(rproc, firmware_p);
> > -
> > -	release_firmware(firmware_p);
> > +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> > +		ret =3D rproc_attach_recovery(rproc);
> > +	else
> > +		ret =3D rproc_firmware_recovery(rproc);
>=20
> This patch contains a serious flaw related to locking that should have be=
en
> obvious when it was put together.  Please go back and carefully review th=
e
> code you are submitting.

I think you mean the following change? In v4, I use rproc_detach, but
I missed to drop the unlock and lock when changing to use __rproc_detach
based on your comments in V4. My bad.
+static int rproc_attach_recovery(struct rproc *rproc)
+{
+       int ret;
+
+       mutex_unlock(&rproc->lock);
+       ret =3D __rproc_detach(rproc);
+       mutex_lock(&rproc->lock);
+       if (ret)
+               return ret;
+
+       return __rproc_attach(rproc);
+}

I will drop the unlock and lock as below.
static int rproc_attach_recovery(struct rproc *rproc)
{
        int ret;

        ret =3D __rproc_detach(rproc);
        if (ret)
                return ret;

        return __rproc_attach(rproc);
}

>=20
> I will not consider another revision of this set until July 15th.

No problem. Hope until then, my v6 patch would not be just
enter into your queue and be the end one :)

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > --
> > 2.25.1
> >
