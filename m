Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6136350A331
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389709AbiDUOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389671AbiDUOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:50:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9BF4348A;
        Thu, 21 Apr 2022 07:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM8wvD215pfXqf5Vy/igwIhikwyVMCbxOpRULchXDXjkIOSvKEM4SitJe2aEwOuTCZy7W1OXzZz3Eb8V/QoYHkbs07KSTOFVTAlPYOWk0CHJBcMuX0TO6iF9ge/zixCb64I/lnGcbMVwEr3rr8EX0AxmGbD2r3zzydFBMRgNrr+1az2w2yU1rnZGseFEGM3jADayl/QhE1RWXBnM1Pj4OtBKexBBt8yVVFr0QfzmDNXrL7gTGg/nVC+C3R5SFVfe69GTgxFV5Klz864ta2AiMq7Efaz/cwVBllpQPJxMOQs2xbc/P+g6dpkrycC9GUCxzb3cayFLW7rB+WjhEabevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pghUWbu9emLzZYVpHnMM7dcL0LqHSNSa0W+F8XX0mxM=;
 b=eP4bh/ENnSufGuyxZvHdVrkKeHk6PllMSxOJyy7hJriazCmHe/UNvNiXiwM4O+sgp41V3ykcIWMFjp8QnmxCQfprfEu0dIdRFN3VlsEOlAefO/yaBl8ozvzFRlrDRz6B2RFUTM7629qqeJuv3WLsX90FS+/0xKKN9Rx6I0lvtm7Jm2+bJhR96wWMxKseh2+txHMcx9wBN6Ynvregoxq3I3/C3vWkFDQtuB7ySlYerHOYOHfrowknmy90qmbX8xEBi2VuGDdgNISRoJ2g9FkPL9YEByh7e2UX7NOaK7GSHvbvvWimAOIJLkZNZnwnBKfQHHLqh89S7bDOuSi4Yj3lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pghUWbu9emLzZYVpHnMM7dcL0LqHSNSa0W+F8XX0mxM=;
 b=DvMnqxjT7e9mstSah8ii2eZl8cXArKcUbjpkIpTbsdu+Nv6hbGPHwyfIX88SA4e3wBtoXUesvInWkgSZpT3i37YKL+wd7UCsSDgq6u552PwiU5l0pyTWLRxcVHYYOZV03hqbA4dDIatNWexVJq7Be8yj7N0W2wwZZqNfcgN2CLE=
Received: from DM6PR21MB1323.namprd21.prod.outlook.com (2603:10b6:5:175::10)
 by MW2PR2101MB1819.namprd21.prod.outlook.com (2603:10b6:302:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Thu, 21 Apr
 2022 14:47:55 +0000
Received: from DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::921:87d4:16e8:128d]) by DM6PR21MB1323.namprd21.prod.outlook.com
 ([fe80::921:87d4:16e8:128d%6]) with mapi id 15.20.5206.003; Thu, 21 Apr 2022
 14:47:55 +0000
From:   Jarrett Schultz <jaschultz@microsoft.com>
To:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/4] dt-bindings: platform: microsoft:
 Document surface xbl
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/4] dt-bindings: platform: microsoft:
 Document surface xbl
Thread-Index: AQHYT2Q+xTtCZGJgoESLP31oIY2B9qz2ThnggAQvmRA=
Date:   Thu, 21 Apr 2022 14:47:55 +0000
Message-ID: <DM6PR21MB1323AB0E718426B14E13386CA5F49@DM6PR21MB1323.namprd21.prod.outlook.com>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
 <20220405210750.619511-2-jaschultzMS@gmail.com>
 <YlcWD3dnqotAEnfA@robh.at.kernel.org>
 <DM6PR21MB1323C72F2B37419069407AC8A5F39@DM6PR21MB1323.namprd21.prod.outlook.com>
In-Reply-To: <DM6PR21MB1323C72F2B37419069407AC8A5F39@DM6PR21MB1323.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e534c7fc-2671-40ff-858e-c7400d233291;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-18T22:48:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6691dce2-42e8-410c-4398-08da23a5eb8d
x-ms-traffictypediagnostic: MW2PR2101MB1819:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB181972276ACED8EB0BE59DACA5F49@MW2PR2101MB1819.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T4QRa+K+bSLiBtWK9X0uVYl2wN6P0Txt+r1KpVCap+fCtjzhmIev46Py2PVqQz+PlqHbnJDMTvtnNG4/vOZhiLyDGVfoxOrwANn1i0TFIBPlZO5Rp+mr68wYjs1Kmr7cVY79O+6a6/6h9dGUnR5GoALlfhc96DiTi1pOWbZ3NyHDAwE3Ut56s+YK3eUGEaGrM/Wkf/dEn/mT4W190Gb9iNHh8Byzu/3mid5PoV6THNjJod+WKLFH+o4LJAYf18rxRUNkSkwNTb1z96vcXETWhZrFFrtNqbIAa5uYEg6a1PoaWQHL1aALTvk9y/yLkYuU7MC8sSbzBkXF4skVIAqIXyEaBeltB5jLFBYTPKuC0y+Nni0s4+g+VbAZpU7A/Zu/G8g1sulDBZgUuWmevQMK1aiAMHpZcPmF/eZ0ZYTtL5+ABim3dBCq/Ci3NGsfv8XA0rODlKC6JJD63CT8W5ROI0mxH8clCfCvqd8+jFjs2qPZANVrjs1RmZDFsXX/Rsb1nchF/soHMC6Om8DQiRNUd37UArQoW25NcU0EyQ38VpfFvZ0DHwBP0cTee+xwpXs75E/x/5kcSbPA309Zb8zx6PsHGn9KhoZZq+LWv0Uh/q/IZOB4pwqsLug6jVobogurvjmziOz+k2whh3Gcv4GhKP2cHJc+jlrIdvTAMivaaICaLup1IXE+CO3RtPsCd/7DhvkBFbj/+9CcJhHmWbq+JbDak0An3yj/LpqUb4WJc9NBAKZb0uo/yeSCBwJkPMP5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1323.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47530400004)(451199009)(26005)(186003)(55016003)(508600001)(52536014)(38070700005)(53546011)(6506007)(71200400001)(9686003)(7696005)(122000001)(38100700002)(33656002)(82960400001)(82950400001)(86362001)(5660300002)(66946007)(7416002)(8936002)(54906003)(66446008)(8990500004)(64756008)(66476007)(66556008)(10290500003)(110136005)(8676002)(4326008)(2906002)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lywkbjlp7yX6/jki5WOH1SlqGh9ZVRTQQP4noPpExkCvgfgzU8R10mBJNw7H?=
 =?us-ascii?Q?1L62VtnSWbQ67ibBc1Eos2kUrtRVC//APIfzJBna5AMj6So1wGuGvQFv1Mlc?=
 =?us-ascii?Q?v4q/OPxflSGP7Kz5NOvTaG/wfE/Rt2yfthEvBUMGe2YWM4UrWvgPOTzQdmS/?=
 =?us-ascii?Q?5pazUHX0/y8sY7kvY564roIrE0K9tCeFvXN2csUXZzSz7JlZcGjxkmX4D/Wh?=
 =?us-ascii?Q?4eIEjc8iGrjsMv7PvvFrgvQpt6W/0VY4StZ+CAq3sxhXRPhgiW1yH3PMZtUs?=
 =?us-ascii?Q?vFdYe6A5S02hJkvNFrSXQ5YE5VWpCTOaQxHdyX4UTVanIuLCsMKI+919UEd7?=
 =?us-ascii?Q?jUblCd1KKGV0wHYv6Z4vkWYSzJa/zvdjBNyc5qj0EdgExKTZK1widCgnNjMG?=
 =?us-ascii?Q?Jgx6WWO6tYpy1tDGErHCIuXl+m6gLSN/qV63xDYnvTkHTvVL+qjxm0EWYMVg?=
 =?us-ascii?Q?YHEkulxsPVQ1M8LL6GCoggJDVXnyCfui69XlNY0Uc8+ezu7lVLrjlQQ8N8um?=
 =?us-ascii?Q?taTEGB+7+0QRU3C/XTWji9DzvxPAnyURaVIi92AECqI69NlCtLJ/X34rWC/X?=
 =?us-ascii?Q?yHUIozqrllGnVl72uSviYKtgRItHlR1jkoFdp9WhfNiafHRYjZu/EzlrQ5gK?=
 =?us-ascii?Q?+AtzhLTAdpYacjzkfWe4J1thVR70Jf+iSMuONIO3Hgq2be/GJ/UamNFeuwYO?=
 =?us-ascii?Q?QNgXWqQaW/uWJyMppp03n65w6jZbLTeNjBW+Q6bBZiMwxIxE4YLQtpdvhjWk?=
 =?us-ascii?Q?vuk3257IN9GRDrHELPx9Pu871oOhl9tRwUixJWj0pAvuZ/NpeGTvb4yRsVYf?=
 =?us-ascii?Q?pJA/LZjssXL5TgzfpywHtEtT8tjO80tbIk19pecYhZkd68Xrrg8kuRzM91KO?=
 =?us-ascii?Q?LGi+dBXtRCyJ+6D1RnifAjjjKcglm808LgHUjeOejmb2udertl6YRUxMqh+o?=
 =?us-ascii?Q?X4C5YavBBQBxQbezmzEwZBXclqfhlsaF5yYthiyNGeUOd5Ao/gvr2JCMSSEu?=
 =?us-ascii?Q?hrnPW27gVY6IJNFXGb/5RfKyT54lT8LwsWjZDxA5611HDWYExNzlc8VrAh9L?=
 =?us-ascii?Q?P5TCqq9asivUa95rle4Zyl9T37gkYcxvpV2JupGaPsHTgSNjj6fEho6zPdsZ?=
 =?us-ascii?Q?V289x2iOf3MxCUPXzb2xsOTeUp9JXGS3INZ1BL0yHSa8FOuPMyWMufn+sddz?=
 =?us-ascii?Q?DvAg2IF3zbyCW+opglGd04tjtCPrcx6qiO79Lo6272w8JFqmLx2v3ECcnpfc?=
 =?us-ascii?Q?MSxMRuq3RaNqcLyi/Ri6abyTqAbzU+yIDHauUJrZr8n48W5XU6ttjwF1JJQw?=
 =?us-ascii?Q?AnRf/IPOBX+8O1Mr3n5p7XOPIzUmN8vPVL+4H/aismsxDheh9AvAkBYyF+/R?=
 =?us-ascii?Q?MKzC0HXhTuDcprfAQU3nLOiU+rHdjUBLqYiEtlZxLLLy+OL9+9nmTXjUA+E6?=
 =?us-ascii?Q?TZuZJ6KWCOWQ+YGX31mWrW0n+I0JzEtbNTzoambr0kfw0zQCKk53fpPMcohN?=
 =?us-ascii?Q?1VGPCmGwT+mbI7YVhZU/1/1WvSf+dxNa7DlzpeujK/Idq1FLdjzrvizVy26/?=
 =?us-ascii?Q?BgP+NZLDC9kuWfGux9YuaAoCDkaHIKcXK1M9sSIaRbJm3gvOoJ7JifpAg7jR?=
 =?us-ascii?Q?nnNtcayQMfGyNo4YPDK8BGX30/W5FGfkaIvuEuPeUDRWANpMQ5DaCpntvKO5?=
 =?us-ascii?Q?xz3fXQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1323.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6691dce2-42e8-410c-4398-08da23a5eb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:47:55.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGY6Bc98ma+cO60Mk0w4Iu6dJOkeELhcb9qg9uQPNlxqWzBugtEeXIYNzzNOZmaEAkd+EWuFjIB1dqb3Rpyvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1819
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday, April 18, 2022 3:53 PM, Jarrett Schultz wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
>
> > From: Rob Herring <robh@kernel.org>
> > On Wednesday, April 13, 2022 at 11:27 AM, Rob wrote:
> >
> > On Tue, Apr 05, 2022 at 02:07:47PM -0700, Jarrett Schultz wrote:
> > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > >
> > > Introduce yaml for surface xbl driver.
> >
> > From Bjorn's reply on v4, it sounds like the QCom folks need to work
> > out how to describe 'imem' first. I'd think that would use 'mmio-sram'
> > binding and then this could be a child of that. If it's DDR, then it
> > belongs under /reserved-memory node. Either way, that's all kind of
> > outside the scope of the binding unless there's something special about
> 'imem'.
> >
> > >
> > > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > >
>=20
> Hi Rajendra and Vinod,
>=20
> I'm currently working with Felipe Balbi on submitting an XBL driver that =
reads
> from imem.
> Could you help me properly describe the 'imem' binding for sm8150?
>=20
> Thank you,
> Jarrett Schultz

Oops, forgot to CC in Vinod and Rejendra.

-Jarrett
