Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD38552316
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiFTRwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiFTRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:52:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF32BF5A;
        Mon, 20 Jun 2022 10:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aysvEL7M6wv+vJ/b2uiToi93MgvTlGkCUCId1qf/tBxyp25y8r+G8m/QvdawDprzaGHpZA/v6J4Y/uBoTheSIUUqcCakpH+5KKITdDVjJOiCbwNtwgG9DkFb/uve+xxzgS6yztrW1TG7LSSh5QARe4VAMnHDZy49+SGrlcuH5hbIXctF2smWICCVF3fZgdsCGNL3/A08FWai5rQcGjsNCsecSewhJ7dsE1sR3MAluregKoBVpcazElAkOLSgxSfsTLU0L8uK9ODwCf63j2nlSrALTP5SZ1S8SQcUAK3/GeCrpcrxFQXqDRmPQ1x3zHGhuu4bra8MMlxg2ZWRXqCkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws+qG7iMZKtJMBuforgYpRH1oYXrHuwoifOgsmi4Kio=;
 b=KMObwNKaqn5nvr5xzU0o2z9Cf/lb+cB4yCTQoyqHq722KMXg1/pRw8hldA1Hjyii8PRV3lqeOONzWOQfbQpp6heTCQqKI8OSgyIkCfmoEBYRk6dGfbeBQBqo7vEJrG8Hi7TAVfs1BzckmvmtbGNBkoRxUfjrvuzieGcwQlUdi/XrC5kXTjIyhrgFjuAgBT8WydYAcDigHAi6UkzwL+E+fqWSYfLg/K7JQD9ugNYrcOd40lArFPJhg4WKvDBe9gJuwdOsrjMtFvsJbxWn9wyd3XpNTSP66XTTa6/0iApKhzVAZeaVOcsw7Zh2jG78htVVgAAgiTnTgugT7djlFtMEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws+qG7iMZKtJMBuforgYpRH1oYXrHuwoifOgsmi4Kio=;
 b=l0BtK0ShnAvirfT26Hv3jMT47mumBHP37MmIMcuYJ7NU2Ro605BHDP7SGW0Mo1mlyHfKfk4SmS1OgzMVCZbVxtyZywL1x2zJkwjZ2LWIc+aWiBa7rpYkPdrGE/n1VR+l7iou7EuixeZLmWkIzCBnOE8Ef/91EYuHfPLocuFVB+pFKP+NraHu1diydJB7Yc7Jrtq8IwcebXbXaosMagyKS8LU7zu2Q1gN1timrnzB1A08huGKjkzpEsTdyG8U5UZAS6Z0YVru3oG4ViLWAzhg1XRRnGZ7LWzB+iMXT1hj2gNHTRNoWqhcpOR9VvxtNl0UgeTalV0kReV4CyUtSEkHHw==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 17:52:43 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 17:52:43 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Topic: [PATCH 4/4] ASoC: wm8904: add DMIC support
Thread-Index: AQHYhM5I8zJ1RgAco0OUsREGZzcXTQ==
Date:   Mon, 20 Jun 2022 17:52:43 +0000
Message-ID: <AM6PR08MB43760A5F78137DAE68FE99C7FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a14b0724-4047-00df-9794-1cdf0257c48d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dcc912b-202a-4ff1-2999-08da52e5ad06
x-ms-traffictypediagnostic: AM9PR08MB6258:EE_
x-microsoft-antispam-prvs: <AM9PR08MB625831458D4ECA05DDE2C296FFB09@AM9PR08MB6258.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qhullmlzwck5iydBaQz6e1BvvKUiPpTKGltWbJDxv84LBdXhmZG6Du9k39ZDCf7BH6BJ/dP1WVYmTrWo7JoTG9TN22rNX79mhJ93abcCG1n6g1fya36y5ZQZVdLYWc6pQukOUrXtPAh6qozyO74yZBGQHL2E/B9zYlFSy7oxeKahx0Nv5mUuS4p7pMrnPcsfp6pnb4GN6zQ/k67ONytI8KDxzfoy8UDFeX49fMi0JLBr5d+JJTps8m04q7jEPU2XXCSKxtkBwF5bUANL0GUWgZb9wdrZ2/ZB54cEZIOuz7IPpr3Y3tGQX/zpO8WPfZEu7d9kn/IIp2UxU2dsnkugqMoib+MzlEzbmYW46GOc15dx8DV5EQ+i3PDm9+8wj+yntSGF92nBdTzyvO1s4zkv5vkNOJu0dlcm8x2nJCECtZ7qzdef9MPr+wejnhpD6dLyX7ila9FbxeRK+yEDP9ulK7Z26wJPig+xBLZ/bYlENxa4QieDGGL9M7EKEgQWtMvou9ChiF9VXIoeNfKYphUazT7iPC/OSawkGZf41z7GE+SoqQfmPg+nkDY2U51GVETIKARJO5+5S+bV3VUMfgKlmqNwzo3tjrhbtenL012ey7C1mL5DKyvjDqdHweDEPtAFmf6kgKbB7hapkaNv+Q8bG1iuSgyhmj/rM7+rdesmndDyptXpXrC02GiqDXutAAM9kZciLWMNAqTwElIXjcK+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39850400004)(396003)(136003)(66446008)(8936002)(52536014)(76116006)(66556008)(316002)(8676002)(5660300002)(6916009)(66946007)(91956017)(54906003)(2906002)(71200400001)(4326008)(478600001)(33656002)(64756008)(66476007)(7416002)(55016003)(7696005)(26005)(122000001)(6506007)(38100700002)(86362001)(38070700005)(9686003)(83380400001)(41300700001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ItW/U5naaeyBYPIpeGtbxcQ/3CEUoO0KefeBheVf3X/6jSt4KfcTmw8twX?=
 =?iso-8859-1?Q?9bjDOkgd2MmqS7hAt1b5VMpkqyfN0hTnh7U9hFRLK0vLljee2skMlDe1x1?=
 =?iso-8859-1?Q?c7xmEOgURJG42k2vooVcIY9C9tXMqXBUA+O3SFtELe/GyQuPMg3ei8hBQr?=
 =?iso-8859-1?Q?8NWuK/LulmCuE9EesKhf6jD69KyLWKVQAg6Xrlzs06+f9eOLFBAOMGlNVt?=
 =?iso-8859-1?Q?qz5HWs9LGs2m9L7juiLHiqebN+uOHLjUOqE2trzAY/iLilZnVnEQFVcI3K?=
 =?iso-8859-1?Q?8mi86et8ur6GIBCLjESZjt+OPWxm/ouSAGpkHSfj7G9uI1LSBul4PNuPVS?=
 =?iso-8859-1?Q?tdQ8EwgCChwYEUL+0mKEO12L9ZCbluUISwlT338NNRb3UMg0aPhO285Wlp?=
 =?iso-8859-1?Q?TK3ACvfbdHdQuxjp8TpQKJZpbF/Rz/pXtiMLNRxhEYJrZTK/6xaQmUlJ7I?=
 =?iso-8859-1?Q?dOg+27JTYC+wVaPlRwvSFuZMbCv7KaUA6JPu0dbzYLDYLcTb86i1s5UIch?=
 =?iso-8859-1?Q?W3ZRTjW4mVxOc0b/bOma8ilX/ovrAzIjcsSn0Wi7Dozz7MHsXVqXXJK0IP?=
 =?iso-8859-1?Q?PRsp+KZWYqOrryLBaHEvHjvvsVgxmVCkdEIrYyPnVNKpoVxSdwcePXE9j3?=
 =?iso-8859-1?Q?JiCy7Vf0SP6dKuID6eXdNCt7sJQpgnKE6Aq0P50Iz2xRMujtp7xyMKO9yk?=
 =?iso-8859-1?Q?1s/IyGVyX/32VxLP8pLcF6NkGTbyH9X1+saoMYML9oj9Q6RFqmmrqo1ZZi?=
 =?iso-8859-1?Q?0ilcTab6pdM+HIfI84MG/tYVhd4J43Iv73pAj2P827p0HV0sbSjqYTsaSA?=
 =?iso-8859-1?Q?fakAriqZ187wfgChZKKkdCW05QNn/guzMfPcvxMnZxGhS7+Vaf6UqKhN/5?=
 =?iso-8859-1?Q?8jzO5ZbSHtVbd3oW8C53hIl+5u0Q45096It4kVb1DmW0+jXgbimp9/4is2?=
 =?iso-8859-1?Q?2ApjEhJ7a2Zm3xIyllXOGhx7a3HeO4zYHSH3MzB9BNw9TRyF7aq2vRgfXm?=
 =?iso-8859-1?Q?ivDCn9jeGzqEIDlbDvd/Uokke/1eBF0CsqabUh8yhIZ0TMMiQ1NXn3Zcdy?=
 =?iso-8859-1?Q?I1D7DVt8uZnDqcfW176b73lAJxLawgZS2ahrPgsIIeJchasODe0NGYGBzC?=
 =?iso-8859-1?Q?/ObmhnnGQBeGD7xO0eVLHMaMZPlIa3MU8Wx+63qjf2L5PQhePC78bPLdTp?=
 =?iso-8859-1?Q?wfuGoIT95bYThBroLCz/LHl1pcB0fgGHo6d0mYDYMH5bhqvPEaKn4/Ije5?=
 =?iso-8859-1?Q?Du098MjI3AbO8wx/YpjKRM4AnqmAylGythlSfdwGcYmffnApAEciKmwg2j?=
 =?iso-8859-1?Q?H/rn6jRYN3CVCfTsOseYxc3f0/O8LraR6QFhnxo4XIK4gO02MuqqQg2Jb3?=
 =?iso-8859-1?Q?i/uTmQRPjMhY+28h4j3F77c93ALfP8G7bLPbv63bGqZFGhthBkAQJLip71?=
 =?iso-8859-1?Q?mBECSiR10rAya9B/e1Zh+jMO4jbdcujacOfSMVulYICxzpdO8nt32glU+0?=
 =?iso-8859-1?Q?TOXRRmU7eMxJt4Y4lDQK/ysauelWK8dKYxuHQDhqKxGZbszInhwjWK1Zf8?=
 =?iso-8859-1?Q?P2Qiic2aY2pSNbVqyH670ACb8jDxUan6yQPzLw9LnA+EqfkCt+oHpEH1/+?=
 =?iso-8859-1?Q?yBd/6rZJlc+z6SItMR4dPAKNKRxEwTG4B6R37GoXuelfZBEFYclunkZ4RD?=
 =?iso-8859-1?Q?d8zfuXj7xGyK1RRmle9tG28zt++WkA2ygk/biv0zjMiiSUxju8pFzH5vTE?=
 =?iso-8859-1?Q?xIx0UQxGvK695P1xK6SgwG4v2MFoNvCiTUHmQg0JM311nOpTY5Du7Ms/j0?=
 =?iso-8859-1?Q?L6NdzrwV/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcc912b-202a-4ff1-2999-08da52e5ad06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 17:52:43.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwKb1GJnQ/9kKGeAZBhtMjvmb4PexXGQtQeXxxr5+0+7Ew2vYLGYz8LCKD+vV6kpRFKX3uNSLgTz+zC/SEk/tO/Iy9RNOGLvPntJl83au7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just for my understanding, are you suggesting to set a device tree=0A=
> > property to force a fixed behavior in the driver ?=0A=
=0A=
> Yes.=0A=
=0A=
Why should we use a fixed behavior ?=0A=
=0A=
> > WM8904 allows using both a DMIC and LINEIN, switching between one or=0A=
> > the other and this is how we currently use it.=0A=
> > Why the user should not be allowed to switch between DMIC and LINEIN ?=
=0A=
=0A=
> The device shares pins between the line inputs and the DMIC inputs so at=
=0A=
> least some of the configuration is going to be determinted at system=0A=
> design time, that will fix the usable values of at least one of the=0A=
> controls which ought to be reflected in the runtime behaviour.=0A=
=0A=
In our design we use:=0A=
- pin 1: DMIC_CLK=0A=
- pin 24: LINEIN2R=0A=
- pin 26: LINEIN2L=0A=
- pin 27: DMIC_DATA=0A=
we have no pins shared among DMIC and LINEIN.=0A=
We have several customer switching between DMIC and LINEIN at runtime.=0A=
=0A=
> Please fix your mail client to word wrap within paragraphs at something=
=0A=
> substantially less than 80 columns.  Doing this makes your messages much=
=0A=
> easier to read and reply to.=0A=
=0A=
I beg your pardon: it should be fixed now.=
