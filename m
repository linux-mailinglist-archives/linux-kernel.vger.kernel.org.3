Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3534DA089
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbiCOQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349326AbiCOQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:55:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92405642F;
        Tue, 15 Mar 2022 09:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBofL5FUjbnIeTZ5/39+x98/MIDQIj9168JcwP84+C00uoQXAn1E1HFgU4e/D5o5UZ3+MCT6mumQO3Lx38bqFweWxxZyZYzJ9yiEGkcM/SccuBGkvcfcNi+jRhlkS6daSMUOozczr5H5Vb4otZkd7cjEuOrp6dCx9AsmE3xjG1EF3c4up7b0A7zQpxja6FItJPcHl6h5V+6YQGoDF0DU2GTtKwxAuungq9dbtfIXa8DvgPay1SnWRwi8Fb31s/ic3kAphT4BiSfjiCSmJL18IVfdIvnnzXGbiZtwk1vx6Hxx8IiQg7S/kFlC3hlyqAxsxPUTOPVyNcXfVDSDJu3ZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtLnt4UqcIxCcuYgJEdWwvrV1YKuSXcBhtoCdbKucKo=;
 b=NjSE85uDGTOaBf59/ofhQmsE+DDxSH2OPaggXM4GN52Stwr+W1U8bg9X+damVN+IKfkO5w+o2qT1TUZZk/7axgVcierlIQyrTLlKFAkJODfDyN8N8Lq/YA7ofNpJehUErR8R5O5+3GgxalV/Q7ZDl6tXYCc+NQBTzMBVoulvbixw8CiXjOwvXgHwWyqdwUH3dwRvg+j106wpvfWq9jMNPGfw6GuIGxN0uDfgb5Jo/nA2xGs/LC1sCpL4LUp/oqQk/4X0w6gdKP865nyvbO6aQ+ycM/XRo3L+CbFnlePqlDlYVuMgS6i9DcX3y6w14rzL0A4aG3qdkS7byZcs4Ch3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtLnt4UqcIxCcuYgJEdWwvrV1YKuSXcBhtoCdbKucKo=;
 b=g16aWovLzBkTnLbG/6G/SF38JVq3fMnrW/6OSqQn1XYH1m1qlkguL43I9mfcwshI1M+DWWAIF5Wh5FOfEwwYzN7wGs2qXy2q3iMuuwSo6RjCF46/rnJCTYEuTqIeWpk1uVrqOjBSZNCAES8cIKq1O2HQu4YbTZhtQ63NDo34BMw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 16:54:08 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 16:54:08 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Thread-Topic: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Thread-Index: AQHYOIlZtJo3mK3DGEGeq+l4FbKrMqzAp92AgAABGzA=
Date:   Tue, 15 Mar 2022 16:54:08 +0000
Message-ID: <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
In-Reply-To: <YjDDUUeZ/dvUZoDN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-15T16:54:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=34519328-a1a0-445e-a02d-e4840280d6a0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-15T16:54:06Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1589981b-6d10-49f2-b2c2-f640889288b9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf4033f3-c17e-4310-0a94-08da06a46c1e
x-ms-traffictypediagnostic: BL1PR12MB5319:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5319CD7C63047FE2EB42D973E2109@BL1PR12MB5319.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAcHkR3pdUBxLEufwjKqndqPbZZiqPL0FZoxxdXGWe3YLQXedg87wZSzz18O+NnaMqNquqUCmrlVdTjUXVgklCkLiD2RZLkXmz/1W0UBD75TZ/M2TRNMGbGc4VCm38SH90YV10xD5OET27gMwXuVed/J9pzm73Qvwmq2dQOWE4vDiXjyRU9ZORgZBSF3T+yuLaWng//ta6zyPXANu+pwjOEiCVEeU+jVuu3Uum589h8bAxXo6XPy2Hh5CDDUusTIKdXbGViQ5AM4AqOUMw/n4VCN1wOXqKnezNcs+tmC2VlDtuPfaQWF8JAhyPzgtOXGBv3ih+9KrdzG5Strn/h5A4xP7uzOTnM8q6O7OUBShY8+JXUk+j8HRCELitjSKs5NxB81Y1IN1SmJK6wajRHJhVXk/DAX1y12mKDvAgLt7zk/6fKxkjNaXVpAI2xTjx4OvdguuqpaMpITGvJXayQPrdJZ7bqPIuVJjV1EezLavLF/mJXli9mH+MSwVM+xjKQg99CZkSKpcOPK8pnEUh07NfFK/fJp0mpl3yjormPU4ouZu166xRK+Q5XkXe24xhohmwzkG1pslrdS/gSZQMM1GlkKHsAIPa7ZjZvm/CvN99dTS2sWd8zSQm/E54zzNEwbDH1WY8HCyshvWfzBNoruXChm/GOMknzrqLtEjZDsu/ZL8iIl8i0TD62Tvo1o3qCBBbXVvYDnRSh0qS3xPTB4qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(9686003)(2906002)(7696005)(6506007)(33656002)(52536014)(7416002)(8936002)(5660300002)(38070700005)(66946007)(186003)(55016003)(38100700002)(122000001)(83380400001)(54906003)(6916009)(76116006)(8676002)(316002)(64756008)(4326008)(66446008)(71200400001)(66476007)(86362001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JSoiLih6GMKj6uwPzIKf+jsBpeVsyRqyKleX+Uw4rc/QnoujFi3d2iuGS9v7?=
 =?us-ascii?Q?IIXyFhZ3w3GW/muLDdL0Wp6ObRf9gPRl9I+CR/pUldJmtpE4/wU1ZWIvB2P9?=
 =?us-ascii?Q?+pKUTXs48y/Fzx6CwkN9JUcIwSG5kNyegXW36BJZKN7vgQ+5BMw3yYvtevRH?=
 =?us-ascii?Q?1fnI3w6UKRHRlc66BmdvwJY0Yh+qvfOfgH6aGnU3wbZTEMgxZ1OT2pRjxW4L?=
 =?us-ascii?Q?DeVyk03ILrkKJ5E+wKm6eVX2Fmep+yuETLRmI/rTLRn3uJFFzNpeG5ckIKWY?=
 =?us-ascii?Q?IOc6BgRMsKFEJjPtpFJWnDEroozXT7YUfV+0nxxubYcpRy0pydO86TSKrXWK?=
 =?us-ascii?Q?nE7P2T+rmOGKoKyHuCrCMRYcTBfLyF+JnMQtwEaKcFlCFjxXfe+rxNN1Vmly?=
 =?us-ascii?Q?lCeq9WptuhNZN4AX6m1OaXix4mtic5wNeg7H7ODk1E7b3jZowLHNBLJB4Fh3?=
 =?us-ascii?Q?DSy6vs9+D0y2wXfv+P7ikHzA/DB0xXMeQ8eHLlLaFQeSmm+NO7RBCYDyNYRq?=
 =?us-ascii?Q?dFK3lFSCnSR1qD1+JJ3h0MCG4QwXUQ/DOPj9hi+5kmr2rvKytFeHQe3itByr?=
 =?us-ascii?Q?JOZ2uFCiXV0C5oqhmbh6sz0V7xt6hKyRyI/Yv8Xy/5XgnsZDBZd8fL9ZuMca?=
 =?us-ascii?Q?5zqf+EItDOXeMPcPLC77bPXuIp2CRF+PCGAbgNf8zQ+aeee/sKONPvybI7GI?=
 =?us-ascii?Q?ZA4vJulfBuKXd9phb8NCeNKUDAwuPUnVZBFPnppNdhBWyGlWBkYZJNj7qVCa?=
 =?us-ascii?Q?9T8VeNCGqZ2w4ms+D/BBcMmbD37fsgnU+3lQfp7DsRsPTUQV9Ie4HhZCF5eF?=
 =?us-ascii?Q?+aEE1I2qx16LUM+bh1oFTRSXYrpW7cuw2gz06rmjetrF3mFGjWEYUHICJM5Z?=
 =?us-ascii?Q?3ZMqvJ8rrh81usSmdVQlp6I2sf+C4y+QsNniIJtUm5z24mnFdjsTKRDLbxFx?=
 =?us-ascii?Q?qVtSkQoXxhURXxjonO3jwO111hA/LYvB0hkypTxX8FgJA6ihtULG12xwB2ui?=
 =?us-ascii?Q?N6GABRnA8cBsv0A276bOqF/ZS9EutgiMo1PiR7LvbQP2HSKpZ5qnGzeAvROY?=
 =?us-ascii?Q?hkZFu8d9PRXINgGgtqH2873Yf9U3JbhrOY7/VIK1l5GFHURDmfWwFpV4iLhN?=
 =?us-ascii?Q?fGNeF3KUYSoCn8sypTAIkGLd83VEjSc/tJETK6F+3kUM9JTrDAjMl1pQ6Qs0?=
 =?us-ascii?Q?jJBSuyq2lZv1WoqbWKQG0GKiG9ZxFIIJ2cKkrEi9fVQENn9f30T2T5+JmZj2?=
 =?us-ascii?Q?7AoNI6YKREiNjwxRFfR2pFXK5fGSbVlbfucBqB0Dfkz1/bEEMj0GZ2YuiaYH?=
 =?us-ascii?Q?YZhLHzssMsOlyEd0yXd14QHNqt15rBv5HXAAvkwuMCtc+cDZ5VWcUEvgjz/7?=
 =?us-ascii?Q?Bc3kZ+t4HQTOSl3W0hVL33U6jy+D3UPZ59s292ZZjk1LcBvs+pBC9R81tZ8y?=
 =?us-ascii?Q?GAXZxluK/a//DvdkMxHjUqBY+nX5vUF8Zos8vZxotWLCI49dNePmSajdx8uV?=
 =?us-ascii?Q?ITY1BkD3AQckIQNGHIFw6/MnIEACbJK8bTgZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4033f3-c17e-4310-0a94-08da06a46c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 16:54:08.4189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2PkouKYec+YKCWB0DE2ONpk0XeRuLhhzFywOkWHw9xkUahCKhP/412Pk6GiHSuRHck3+EtUHiPPrdE1WL8OZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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


> On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
> > -	 * handled natively using IOMMU. It is enabled when IOMMU is
> > -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> > +	 * handled natively using IOMMU. It is enabled when the IOMMU is
> > +	 * enabled and either:
> > +	 * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
> > +	 * or
> > +	 * ACPI IVRS table has DMA_REMAP bitset
> >  	 */
> >  	return sprintf(buf, "%d\n",
> > -		       iommu_present(&pci_bus_type) &&
> dmar_platform_optin());
> > +		       iommu_present(&pci_bus_type) &&
> > +		       (dmar_platform_optin() || amd_ivrs_remap_support()));
>=20
> Yikes.  No, the thunderbot code does not have any business poking into
> either dmar_platform_optin or amd_ivrs_remap_support.  This needs
> a proper abstration from the IOMMU code.

To make sure I follow your ask - it's to make a new generic iommu function
That would check dmar/ivrs, and switch out thunderbolt domain.c to use the
symbol?

I'm happy to rework that if that is what you want.
Do you have a preferred proposed function name for that?
