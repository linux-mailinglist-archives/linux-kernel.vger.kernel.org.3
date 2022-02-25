Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902FF4C4A13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiBYQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiBYQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:05:08 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8171A3617;
        Fri, 25 Feb 2022 08:04:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4jccl8KE6XltWYz2OabuF/OZ/J2g+JNkwFHR/AjLXpfDdt2TUMB6TPSZKFZigg3Nrc7/omSJaIhTPLGL9ndVms8rvIWTd813pRuYByR4A0313fyMa50w6DDZ8x7MNrZqWumtc9BEdM7ahhaM05vXhhxejtxqyUok9jyG1t5hzdd9a/xnnmKweb+6y4RFmYmHRwhGWpy7cl2obWQI7MJxhWF8sgwDsATVYHXyEZ71+xNzRrTyuDSiQzzFVwbBKGqWeluDWKw24GVSmRO05zVdNBZXW5C0UMioM/lBym5arUB9tSC6KASf6tcbJvxVC/c28ztH8PePzOm/fkbyfBgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF9hLLEmrOnEMAfAdKSQL7R+8c0VyKj2UPugoGNc/V8=;
 b=mj0Qk5KBHfnRwSsIXPPh7QJXucuc4AW3XIEY6eSDZo6sd5M7k46i1iOarTNNRjXDY4sCvrrNh1ufSIkPkcNoi2aWpvbq1adtS1N4l43uIFec7n4KWApKBAKfd+m94Vfr3S6V6nbuWMlVxo8XuHadteFo14iHnbGI9lIIEJqxEXx9wb+xdSJI2+ElrEjPisctS6VgIoenybpOJdNwcVco6QqpQQ6IImI+3T9wMAlvvW0FoPeCfvc2DTLqmAfo1d5g3WKy92MYE6bQsaPrmpdWATagsdU5+kjz2gpgMN6vOpwf0wgJhmAHrwbTClJ+SZT7kSkcSN2u1Ythn2G8vODRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF9hLLEmrOnEMAfAdKSQL7R+8c0VyKj2UPugoGNc/V8=;
 b=j5nbZA1Fz2IH30Yp8ppZ5c2QolyhDzDw51RUn6pNcSsmXYeHV1vzBS9asMWjqhPJX7DcxCJRb9Deop5iqtgEC13NMjq9fFqwSwlmFaT/oZ43OAqusoBL2+3cnqVB+aJ8YQhHfRzb2G3q2II3ZDcZRMdekD816pvkxOHBooUgT+g=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 16:04:33 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 16:04:33 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Thread-Topic: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Thread-Index: AQHYKg7avs0NJxq2CkGM0DSkmy8He6ykbaaAgAAAfcA=
Date:   Fri, 25 Feb 2022 16:04:33 +0000
Message-ID: <BL1PR12MB5157D29423AE95EE32F00303E23E9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220225061113.223920-1-mario.limonciello@amd.com>
 <Yhj9Pdp/sHASmBw4@infradead.org>
In-Reply-To: <Yhj9Pdp/sHASmBw4@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-25T16:04:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4005d501-7ee3-4b24-b18d-a14a12c25b0a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-25T16:04:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3d95bd5a-71b0-44aa-8ea6-82378d6e239e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eb591f3-917b-4c29-d046-08d9f878838b
x-ms-traffictypediagnostic: DM6PR12MB2956:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2956ACD86B36EF5070806EE7E23E9@DM6PR12MB2956.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mTkJEGF+7uuINdlirWbVxzkPq4W6znXVLiTEV0ot1H7WAv4+C/S64U5JuztGDlYwG3sEo57PYyJKbLrmvQLbEysZ/lQt1Xrc+z8+zcbZKjQQwmvYBmWKm22VfMS+w2IKShsBCBi0bIgxKmp/0qtwDnFssJuRRC54JzBrwSckyzqrfyEdIjFZrwSaLaMDcgFfYbecKWy3t0tMaTRpgDktVqV4rKkmpwKrsK8gAoVucyI8wwmBaeXZpalVpOLv6TqJYmb6yk6BMZbmz7Qmr4caQxcZjsMNSdS0H4q9GaNZNdoK3/2OeIitCniVkU2j6MAPx1cscljNhBKvu3gFP5JbXqhmCBcASRXgKFJdkC5zXj7CoCq7txswJq/zxhhqywdHemZyLXZnpFMU4bFiimlX1yekX2pEBlKzbGkRxElFYt1Ky1aSCSFTXwglM744w6y7cqXMzamebiSWDfMAwUWxD/Wo85g7jz8S+Mu5fyMwJ8FTnym/Vsyy2wwqEF4HHiRxAFSLD9G0O/fMBhDJXLpqSN0Fc2oc2HilhG8wLt17Rx+yhSygZkpnVJDR4fmrEjh+kSbLtptAoamj4WzsyiCNNaLh6ZFedGYv/WV4MznTiMJMJVR++LphbvcT3ZuCVvffj6FFIiAMlQkn5oZSBaBveMMMdrOQrMzsvIsnygJvE67Ynbi+y4y1aAskwkiCWjldlTl8KryHLauwQVBoLlakg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(26005)(66446008)(71200400001)(76116006)(186003)(508600001)(8676002)(66556008)(66946007)(316002)(86362001)(7696005)(54906003)(6506007)(122000001)(110136005)(66476007)(8936002)(64756008)(4744005)(38100700002)(4326008)(55016003)(5660300002)(52536014)(2906002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VYHEFireYOk+QfFlYrgXcolsxPbBziP2g+NmwG5Un9+VP993F5Pxo+gssaFR?=
 =?us-ascii?Q?Ub+wBlm2iWqM7/eKSNn0g3+Ug/XY6PXL1ysa1vH27bRHpG2dUbjWVLIUmRL9?=
 =?us-ascii?Q?VKOyGSH6V1wUVpChYTClyG4htRge9Abmllz8IRbviu3ph5joRIc9HOY01Ra4?=
 =?us-ascii?Q?61e5xcElsUp5o9hZw/6VR42U7Y8IBJLrYyk5VuU+JuvN9PGNZsi6U13aWI+1?=
 =?us-ascii?Q?rXOB/I2SgcU3eHU7UhcRo9FhCGKtUw5CNWjrcDvrdnzZopE/W46rm8kkz5xG?=
 =?us-ascii?Q?cyJvaJI8C9dWtIYGzBCr+2IbMX2O+VBow0Fmycqjszg1iTFqCTThY2Kwi+su?=
 =?us-ascii?Q?IaaVOBljTPPGA2cYyJkhCXNTYY3Ny8G5ufsYMzYcdUk8TLvqiUTIdj8WTqeU?=
 =?us-ascii?Q?vGG0hoeKk1awkTavMVafrSSJit+IyV2YElV4aiCynWVWiy1rd63clCSU2HIX?=
 =?us-ascii?Q?I4M9B2W83u0VKF0mmh2Dr4kQvTjdlVwwE13wfW20GMby1NGihqso5Rzm3ucn?=
 =?us-ascii?Q?awidOKqjXO4VDFe6lfP1VRWDQ7om1PC8jUkxvVJ9h2Ml5g6GGNPUSOii1TGe?=
 =?us-ascii?Q?mdEY9qqXl6hgtosFGi+v+twav+yRl1q3IKLxaOlUUhoaxbADAAPlwvL5H3me?=
 =?us-ascii?Q?IsH34r8cUkIr8eY36A5ToOU5qeGFz3r5yJ/t5GUAMIcCXupieGRW9oTczsOo?=
 =?us-ascii?Q?yWEdppPQAVxHD2OqtbAj9PzRyI+RYp5Wss2qiyTDWonPfMrKpQ8XREoc9eI1?=
 =?us-ascii?Q?c9OJCggAuavzd2BlE34FOPQqyVwZ8y/PAXeAlhSbuqvbuPyKHma7FJrojf0j?=
 =?us-ascii?Q?mDSNG7FWDdHTrdpSkkjT3yqAIwX+uyodw4DPnO2cuhcKTpGWc59GPm39mkwT?=
 =?us-ascii?Q?pdPu46dHOu7PL733wfk8AETILhUjJS98bNiLBzo/IBLp2ZgHI84bqqb3+bn6?=
 =?us-ascii?Q?MS4TtNjtjDInERZtYG1I7ZM1aQsmTvOu1tivAhn8VQL3mW4cLnmEuR1k4Pvk?=
 =?us-ascii?Q?UBEsH5wfsrUiFcnBTE/fW02nLTVmCT3/SYC2T3aM5ZlSIqGnPo/1fDfSuvud?=
 =?us-ascii?Q?kNh6pjarVnHSkqHavwP1J2gmX/0ZuUC/Q8i9Mi8vtkktYkDqZq9O74A9+wGh?=
 =?us-ascii?Q?UX2ztpHW5NCOfn7xKyd+zqxKZq5pC5vXzZeD0MUPP5dENjDq2ypbxYoND6bi?=
 =?us-ascii?Q?PzfnM8O2Q4HfgAQ0h7l+sPNNbEaBjuXPZQNtQt9ltKCCpsIsxAD85DAR3rrq?=
 =?us-ascii?Q?agzgepE45vweB9VBTpThI7RjQNxrS+AGLrfqQjp2b6f3b5Ac4wuuZ6VHYae6?=
 =?us-ascii?Q?YzuXoGzXo7AAdKd10RCt5OHS7F8BgIalxuYsY1hK3oeG9xD//JlPVyj9i6Nk?=
 =?us-ascii?Q?0RpZoC5TxqI/leWxf6jh3S7wMjBH+pdkVBfRU8ZbxJhtKNX6M7MuAOXSAiSw?=
 =?us-ascii?Q?dpG6vIQCkiGS1335MwxlepYMZ+vbjxEbcMWKx4HunUu4J5qnklKlwxNSiz4v?=
 =?us-ascii?Q?lx+90d2DwRbLz4wGa1j9nHQoRUrBZrYH/jh6lcj0Xzh1I7cp/R1leTlbzsvW?=
 =?us-ascii?Q?4iVmGDYE2uoOYHtNWFmH//6lQXk0JhB7GkRhwPqca6b+CrMevPsy2oKrglHN?=
 =?us-ascii?Q?9CJ8w13cn8s9cHT9/iej4QE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb591f3-917b-4c29-d046-08d9f878838b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 16:04:33.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cY4Vv32B+T9Dc0F1+Zrhf1Jh5IhThYFXt73XxM2SBYpjc9b78E+A9hLxvGdhJizeMxWOAy2UfxwhpgwU1KFFLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> On Fri, Feb 25, 2022 at 12:11:11AM -0600, Mario Limonciello wrote:
> > This board definition was originally created for mobile devices to
> > designate default link power managmeent policy to influence runtime
> > power consumption.
> >
> > As this is interesting for more than just mobile designs, rename the
> > board to `board_ahci_low_power` to make it clear it is about default
> > policy.
>=20
> Is there any good reason to not just apply the policy to all devices
> by default?

That sure would make this all cleaner.

I think Hans knows more of the history here than anyone else.  I had
presumed there was some data loss scenarios with some of the older
chipsets.

Hans?
