Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F85595E71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHPOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHPOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:38:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B598BB92B;
        Tue, 16 Aug 2022 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660660681; x=1692196681;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WCY28cr6sOfrCJZO+LQfhbCdsehlY7O2Pcyh6SDAqfE=;
  b=NcQSYYdN7kY32PkYoAD54k/1r+RweR2EHByVpDstCqJRMZV23IcJhUJB
   X7oDNzoW6GBPmi91zQoa2VuvDNziEGD1xdwIeyofs5akoXPwEvGnuIlnx
   2rPKenGoXOg1PAigzM14HErrP/hP/+9h+tppPqyXQ011vNkLC3vuk/OY/
   x0SxYW5qaSG2ttEIBmXOgtRL4GJ9wbwMPWAOSF0MaSanvv/S1pwNcd47a
   uJWrrEa4mzr/Mlgib4pGXzOQMKt1jUarLKVHsLIzSMvC5RWxuOp3gEiaL
   nalRuAhjjJedL7sVG4wjuvDfpTtB5j4RrcDVxORwrJLy+NjKvVaMf9wif
   w==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654531200"; 
   d="scan'208";a="208840463"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 22:37:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtRVMxahtdgHbN+qpuqAhQqClnT9tMIapgTOP8Vul+zSYZDLNBSFcURuJIGt5X/XJcESQnFqGFcDt1oIoU1oPDxn4rWWY7Mxr2F5NAfQur4CLAGnoUVBTlJyEzvmbzM23OaqOgXkp9X3t3G2GGMoW8iOcpss7umqbx0v4TrmuYn6txyewz91PwicVW15+7SABSQc+A7jwiXWL4KIG45bPR4KJjfTukQfrFuejMoQrt5AwpylZwGIP2cskM/TN6/V5VcFlT1V9jcsA0t+yZYqmR3+WNpNCc+rM6AU8vKtDLNKiqCmERALhPU5UxDXA4/UDF8YoSYd0kycE/GHPmlHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCY28cr6sOfrCJZO+LQfhbCdsehlY7O2Pcyh6SDAqfE=;
 b=FDvLmji6rEgL2f07232wKzamASs1xUcY6EsTBXElM9naRLnW1GI6JdnwU7AJiosFnQQwcOt7TFLwRf8XxoyjHHrGfo+zrc2i1Vh2qjqkzpaPAYvX07J5M6mY/AhwhqQYI82gvZKyXiY+PJeRV1rCupmTl6tZdoODo65o+EHdkkUiWP/gxt4Hxk/h11VGA6bbVO61UMS9Yh3Dggwr+1VJY5w0NKk77S2B1VPMkwoKyzV0IeGuZJPrU6LSXVbELz2hIxszX+bjGAwXn6E+foh0bdRBM5zhVi5uhdS8BP0AylL+yKDyHeob6iY8iFMPmxcFSNQwbmHcwTh2ZPyvhDY0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCY28cr6sOfrCJZO+LQfhbCdsehlY7O2Pcyh6SDAqfE=;
 b=IEyUb2Ra2YRzHcuMB7qrzmz4n3HSpNAlii5S+28RVa+UgrJxEB2TsdLSMyKc/xVMCGlYvPZCJFdmziImHIC6vBW7VvAoesg4UvLxwOE5hzkEIrTuDCRvaLAxirvjRBVe4ZrpdMsAg35vA6ch0DQ9WGZm2dskKCv+/AE74wy8XMk=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SN6PR04MB4525.namprd04.prod.outlook.com (2603:10b6:805:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Tue, 16 Aug
 2022 14:37:59 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d025:4966:3f9b:9117]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d025:4966:3f9b:9117%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:37:59 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Daniil Lunev <dlunev@chromium.org>
CC:     "James@vger.kernel.org" <James@vger.kernel.org>,
        "E.J.Bottomley@vger.kernel.org" <E.J.Bottomley@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "Martin@vger.kernel.org" <Martin@vger.kernel.org>,
        "K.Petersen@vger.kernel.org" <K.Petersen@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bean@vger.kernel.org" <Bean@vger.kernel.org>,
        "Huo@vger.kernel.org" <Huo@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Subject: Recall: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYsX3HfZESvp2h00KmWfyqBOaqCQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 16 Aug 2022 14:37:59 +0000
Message-ID: <BY5PR04MB632751155E8DE96E64B6A329ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53e1b1db-99d7-49e9-3483-08da7f94ea6f
x-ms-traffictypediagnostic: SN6PR04MB4525:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y72aoqGhxnraXtzcilsYl39wLSMt2IZzSLr2waiNvYECUwkUvzHAi6NJ25AtcPs7zX76aGkFAQXXon5KGbN3tjXLk1FBkBltADSTaXAJ2ltDeMT96Z4rRxSuVNfN15I8kd+uJN875Eo5Nbxzm/eZJPCUSB51+dxkz3ItL7TZky79VyXZ0ARhxmP2ewrAsZDwmtHLEk/84oau5lP6zI5FNlVtpxUuiTTUqX05FJZ7sYSeVSWEkmTP43+JLRj3jINm6CX6DIxQbUEy2yl0tqZzONKOS6MiL16tQa1acEBYk/eRnuzIHN4rAh8f5YiG8pcT60Y0/p7B6j3XZ24EDbCoiL5BiO7dokltE2MBzwIBj0EreksM9OOn6UIT6hPKOzwOHIseACAik6q50eZapjxzUM7frWoA6Og4jTYs5Zp8XLJocfQzCazzqz9HukfvJmtd38brzEIeErXFst33filgR5w49fRNT85crEpDHijxAEhTr/81PitizTly8dlf8m/D9hy1KAlGDmS6s1eG/WKQ4Aa5vdCG4q/w8qgYRHPat7pSS4nM4LOyt/x1HvlC28JlIF/PmdtqMKrsIpzcOHXaY4plqT7XQTwFpj8zmY41L8yNrhbncLy6uLVy+ZGPnVPVgUDePAORDseM9LKpL2G07XKko9PyZWPAfGclRkI2vYq2H+C0dV+bcW/Z8B+/gqg3g4AtI45eJ6zZm1w+Tka16mhMl9v56bWriwNclo616edc79izzd+OXhoEA+RTwupGJwLBbVFyMVOG+bl+j3vKZ+UVOSrgpw4JyRaKni73t/egY+aTcF3kOBp/yH9aFdm0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(5660300002)(8676002)(478600001)(8936002)(186003)(55016003)(64756008)(76116006)(52536014)(66476007)(38070700005)(558084003)(66556008)(7416002)(66946007)(33656002)(4326008)(66446008)(83380400001)(9686003)(2906002)(86362001)(122000001)(82960400001)(6506007)(7696005)(71200400001)(41300700001)(26005)(316002)(38100700002)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zA07INmBZtghb/vIlGBQsf7veeRdNybH9rhVIoWHldv0OCYNagmCeZ24bx36?=
 =?us-ascii?Q?Kw6fTaCZkUgF4F4TRPYBApsZWDmMZQCk3FO1fPrnRrOpLz+w/ihl+YpdwYBJ?=
 =?us-ascii?Q?0EoCPPx5WPOh6NJRSCybf0Xrq7TlK2HF5ZFD5SM98SrTlrbRo6Ury3NUfy7E?=
 =?us-ascii?Q?mqLJKcBzl3nn2ZENcYaKmlXRxp6oQffU7ubaG19xLj1fsV7xkRNqhgo7y/l7?=
 =?us-ascii?Q?Dp//a57dXqtLu4+JldDu9uco/HZS/FKYIVHJfChnIqFyjAI1Ft2X8tKvHg8t?=
 =?us-ascii?Q?cbgIGn/yKI0KuOOgAGUIX+7EiUY53bg0pcFhWvT9L8/9uzUwT/SQPLhfTLrm?=
 =?us-ascii?Q?q40xnlohWfqYJ8CnThCboKu8k8CrdjVzvaja8CBN3CkGHnrV2oeYvksEyVBQ?=
 =?us-ascii?Q?wcr6a5Huv4zbWNvWeAI/AHutjDyyBLnwXiXFUswYGrQENYVYuxPe07VT2KXf?=
 =?us-ascii?Q?1UdvdGcCeH8PyLOvMEYei/rbLWscnaWqXyF6Sok3hX4LChUCAhX4yzZI/bQH?=
 =?us-ascii?Q?QHEft6nyIG0Cj7PU5xHI2pQGSrsTZgbgZJP5Dc7HD+6WEaHtO4uJL/ZqJVHL?=
 =?us-ascii?Q?VQS7vxZEMxU8Qg5ZsL+cLwZFwD5/O7O6bbwUkKBBeRD6AneYNoF5b9HCZ+Yr?=
 =?us-ascii?Q?KK2xva9ezzS3x5vvThcHsRTt1yTghy8Yl4+P0bNCSaFhGSkIi/QVo2V5wh24?=
 =?us-ascii?Q?QEgGhTYjc0mhkjB4llQOKbyGtYkXesYz7HPXPxXazoTtEsY74ljW7x1noqv3?=
 =?us-ascii?Q?GZzEAJR9XI8oFTK53gyNheWXEYtrjctnvLAxa2lDvH1oNroqb1zMiEM0MmzF?=
 =?us-ascii?Q?YVRHQqxataRu1CabH+d2tuffu2PyYCtHyWutMItad1q+fAmEgEL2uLSuLh8T?=
 =?us-ascii?Q?E7uyWPVcl4vOxjTA89/ZURXTRsYz3BCy+wofYWDTi3IsTHlTSz+nBxln+mEi?=
 =?us-ascii?Q?o17o/dPKF5nGub2Peu1lMy2t+raFU9618wsCB5WjmQE292AcNTYe3L+e6i4/?=
 =?us-ascii?Q?S/e/xNIfVXhMXNlrq8YFHexJwzgwTeHcW/fxmaN+uQsNij6OykdMgZLs5kSg?=
 =?us-ascii?Q?sniyZttvBDAo8awTZt0eltd1qX/yCQ+FkJrBkxk+DKNLUEdMVXF5nj+KEQbI?=
 =?us-ascii?Q?HXh4y1IyKMy/qXhdJ1Op+AW8MV/jx3jZT8zkKip3BZel29SMglNnwU4viGAD?=
 =?us-ascii?Q?sC7prX2ZhL/y8MyZaiJGfLOPS/sWQoBuzGBekDergjt66QK7hwXH8XuGn4Oc?=
 =?us-ascii?Q?G8GQtCtlbG1/8TsmKp5bUq4aCIiSiMryB/Oxv8+euZWUrExl4kDPg9yJZC0Z?=
 =?us-ascii?Q?o0BRwcErW5nufm8Bt694IPH+Y5L4jnpot3+A2Dd3J/8ryWoNkaN5VKZiMjPS?=
 =?us-ascii?Q?1jKNPfkA+kTDrcrPtl9S4gWUETzLqUcKW/ZfBRDg7mZSjQmYzDxbKvFJnYCC?=
 =?us-ascii?Q?ImSK4A0dCqTGjM/7Jdotxt4EgBIXVKUU0NCVtkUSc/r6gsy+wqVNi0lAXch8?=
 =?us-ascii?Q?FL/7DDvTfq9fhtKOs/b9EFTD1GRAYy0kTo3V6VGBjP2NVdn4pu7Z0ixJtKp9?=
 =?us-ascii?Q?EcD4qHZvNDrDXro2MvlFmsf68EBu0AjqahCy7kfG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rIHwqHl42RLrj4FRsnnUddEXaI35mlV158E6x2opxMEn/bmyHQlfl1LqtARk?=
 =?us-ascii?Q?UI0woZxOfqFnoBdN0wgmUYSFToaJFbc8uVu7yWSprWP+5dUydOaKisefjOlP?=
 =?us-ascii?Q?7SYevYWyo2kEZUI05L9oHz/l/3GA+5ygzdV9MACekS8tbu7o0B/5JhJDfbss?=
 =?us-ascii?Q?vioCz+crySjKnCtpYaCY3TOwzRGpSxgXbhKzSf8hHhwC1Q3e02hkAkfcGGHF?=
 =?us-ascii?Q?9ndWpe/u4e5mUvb5x7RdtPiobl9Fz9vkS5boquDhAafLlV85jQ5laVwXbXrn?=
 =?us-ascii?Q?2KXP81wYvS+4Pd3/2P7m6yzqMpumYO/6ih79STiHk9T83pQuT4HRBACS6VRl?=
 =?us-ascii?Q?VEEh3/q0Q1iXf6ZBIto0pVl5tkZLwE3wuRdHOj5auly+LZ3tYhQKk3dYFkWB?=
 =?us-ascii?Q?A1y/yWlc2ZKOO1WsJdNj8wfTanbKNeauwrnVFNvYL/xwsp+Dgbk2nNIy9NZK?=
 =?us-ascii?Q?RgzAmwI7bFLvlcKlpVq8ByCwxaqDXb3t1rR9xKq/hkC+VkX/PTVtIP6WURVI?=
 =?us-ascii?Q?aQPDnDXshvNoFs5MNlL9KPS61QGiHiFtWrV4qu43cXR7NKnSSu7WtfOYzp8A?=
 =?us-ascii?Q?Lxfs2N8sJjxZQWN0UnLqIsyztjaok+Z9RbBgfETN16zGPlse9RlNVChReyZt?=
 =?us-ascii?Q?S3zyJ0t8X121hivbG8Vr6kp8LZGoZaYSK+h2QefZNrWEgIWHaQchklekkmDU?=
 =?us-ascii?Q?EOPl1jvS7y1ZkmLz6h+v7eisqPvDlC+WQd+0GJFggDE1ZrMxJlo/eG2UN9Jf?=
 =?us-ascii?Q?D9vD+/DV31ADxzlHkA6douvVrRQ4ZDuaFHUE8IKUImBapaYTQSHgYpWTtMmc?=
 =?us-ascii?Q?I/7jyDlr3c/UlR6km2HvL7vN2DYB/Q5qRvyL94dLFdGj+FOVly5fAbOGurxD?=
 =?us-ascii?Q?OHI9BgrT02XrwghhI7vC9O0tHkKVfpFA7Y0WY0TkNYD5heAK++AZdL/OI3rb?=
 =?us-ascii?Q?6o/EXjZH41MPViPqZGzsL2RyIAkhh5gSVsXwXXSCc6+wQn8Q1kqkl1Vrva+y?=
 =?us-ascii?Q?TVz4/cOZTvdHY4svQ/MoQUO+ha1Y4HSNRP0ZxvfC4EDvFHL1Tqf6prvcsdzc?=
 =?us-ascii?Q?Vw2OH9TqVXCc8ueVBAUk8JRaQ3m/QKiYWyb9YixV7Ady6pcphrHTZF83tP55?=
 =?us-ascii?Q?pQiWYcFPyfdQXWxUjrTwr9aVA8liG8eL6cQpDucatk6W/nSTYSBKsTvrMfki?=
 =?us-ascii?Q?z9MsDErxbp/xSUQ8ZwyXT/Kprscs7lwbHP09MoSZIvVh6iy/gY57u7odbESj?=
 =?us-ascii?Q?tru8FYGHRfwbLJRAjyOHoya08+EmaM9Lt4XStgPqgB10bH+du9d5hMJIWVmF?=
 =?us-ascii?Q?UR4CafejPjD64z168fKeuHMIZVIe3bnebaOIt9i06wJjUTZm9BvVkE2KJriN?=
 =?us-ascii?Q?CspnDugJlK+Jxcl4k9NqY5j4jN4zjRA73D68SyPoCxokIUCS5JDfR45fZOtE?=
 =?us-ascii?Q?/Zd8DK9nMzk=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e1b1db-99d7-49e9-3483-08da7f94ea6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 14:37:59.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUl2IaswGy5C68v/2EWALn+9x/Ca67vDiFyGbd6CipLV5qt6nmqfF7r4zqeKRkJZoB81QISguN1bnnIPhTqOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4525
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Simchaev would like to recall the message, "[PATCH] scsi: ufs-bsg: R=
emove ufs_bsg_get_query_desc_size function".=
