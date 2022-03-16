Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9A4DB05D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353467AbiCPNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiCPNHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:07:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98F6542B;
        Wed, 16 Mar 2022 06:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot6miib+QVpQWHzXKYdOw67DVk4Ilau1iAHGIf7FwuNHx4dDCLPwRpXzrGBJn/Fo1J7NBYRsMBocAWnUEJOIRZOsgzFbaxO+Msn8WjEYmfw0EviQnd6yQZRxYLearokNp+RnLGy3m/a5FLwb/XU992ACLf0GcqGWcuN5iFUjV5HOHNPQ3tkK2vp0seYEGMQg+O0wBH989AJlpn/MsAogv96ApyQshsy/clZtCkBuFcfGz6CI4Tjsn+z3VQF7rEaGvZiAHyS6NZq9BTMN2E29Ha3Y8HuWerJlf2l9ZpZL/i3tR0TRIC88oZg4PJz4Ae+NOt5pK8bPGATF7If9ca7HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTmPRI3TG1EyOT16nr5QSfGozJsBU/3zN7XFVAngt6Y=;
 b=EzZ/cLR04+1mMD/yq75RDwDCxaxPsfBSQrppAgD6do81HogiTF6j7t37sXc6gd0zBRFdtoSObut0r6SJMIyH9oswNnuiJHG1Ozg6w6ahN/r1cOuE+4yVtE8wq/HsaHq6ov+Q/BavdgmhIn9gV6CJdFCzxzU1r1viALWcpX7FtaTc49bI7Qvnx3/k7F0xauZnbG4HZqdFhRKtp4RF7k8xv8cnLSieSlvac61Pd4P0cIjz+877HOY2Sv7cMp0E6WsnQMuDQq2FoXyKehLQ+Fw5dT5HHqElJ7tTIpP61RSaqAgdv1M8PDCjJpCVfp4Z1Xggi/qEE7MwdUjvk1dqQ6cb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTmPRI3TG1EyOT16nr5QSfGozJsBU/3zN7XFVAngt6Y=;
 b=liwSDNDSVqGwh0VzU9ghMLCNb5UB7tfXsxEioG4Ve4OUSq5oq3AljT6OdtaFyeiByiyx60KVIVYqYzEWv6vJy9k8Rf8/ItwIxoVytT6Uj8lPGzlYupOSDEvvq/5frRHZ2GSukxmkOIkNsaKv35fESD9kjCVDbm25Py/IznRQC7E=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:06:24 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:06:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Thread-Topic: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Thread-Index: AQHYOLPjSg5nd+aU5Ue+Y6z60pVXs6zBjSMAgABuJbA=
Date:   Wed, 16 Mar 2022 13:06:24 +0000
Message-ID: <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
 <YjGD7N++F+ioISHb@lahna>
In-Reply-To: <YjGD7N++F+ioISHb@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:06:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7425fe0d-a7b7-4ddf-bace-fcf5c7ba4b26;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-16T13:06:22Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: da4f292f-7a5c-4cc6-96e8-57b8250bf6ad
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00b399ac-bf80-41cd-fefd-08da074dc625
x-ms-traffictypediagnostic: BL1PR12MB5078:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5078975912D79D4F371264B5E2119@BL1PR12MB5078.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+VIvjJT7OOuHL7ljLO8LK5ApUGHJkN/n/lgt/KqBhjSRF36gdwlQbSoBxKZr2irGwcmCDPiRlI8w6QwFKL3GnkeWxHuEERbR4zUt2C6rH9IBdzd8BTYlJEU/jZ94NgccOJafVxIFXZ9DOgapBTx/akfKqvFr/yFrZjQy1aTNTcS0ME7eSsPWR1fpso3RduduZo3kthihSKlxu0kYH/LCYbEhmAs8+nZJPVNhmbVM7dFVaJ7pBwIxSyENtxA2QmNGaMdJhX+FR/mcIgwx/1o0ohXE+4Aja1O+HMok+io1LoWVktjSw7SXVxdTuVWYZDlYefIhYxYwUmXkpSY1ZD+e17bmyxRQNczvbVdH+8NAE+ifdzhGr4UDswZSVCpDf3NMVw2UWmDGijipC7U/EnvfQ9doKyBLlWKV/OUfpBacfucmeOOsb8i5KpnjA6biUkWnACfdWpTVDeWONZ0BARFCAfeOzspSQihPRqeYu3YrmcQMPF/TfGpyIHEcYjNY786ABwWqPdukQ+oYz+O6Wp6ggYIBM0vvOTaKrKFO/FqBhAlVhx/ghrATe2U7fxScoUt/CXAqayBms8b2dCeCDUO0vDDHbx9pFza3pnTLU1k5l6ymJ4ivXQZZWToAyfEu91Rw3mG6bhXvzHN/cRsNvNYoygaHach9AhS58FMYeQyog8x62fdBxpVFBPyjWAKcTE1ftcz47TFxNmIpiYtzoXPWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(83380400001)(86362001)(76116006)(64756008)(66946007)(186003)(66476007)(66556008)(4326008)(8676002)(66446008)(508600001)(5660300002)(38100700002)(8936002)(2906002)(6916009)(52536014)(71200400001)(122000001)(53546011)(6506007)(9686003)(7696005)(38070700005)(316002)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oLWXNGNtx9AJBdu3n5scIHcETjDck/rRgH0HH23ntsvjZwtl3F+SuVvSezXo?=
 =?us-ascii?Q?paTimIl2vhuAb4cV/ByxMTXfr0MYgCQ1cvq3E/WzY0sAR5B30Y5eg4KAHbgm?=
 =?us-ascii?Q?4q2cmdBfdhJUNXamYqWVOnbP1HpAyF60VSxBLTA14ziiIFFbRKnsNtud+8KO?=
 =?us-ascii?Q?jvE0699g+boP4eL0jeWZrdq01xTU43O/p1qxeN7+slLZdWicBI5ctqXqCHyn?=
 =?us-ascii?Q?/+lr8fBvBoARjxqrGmcA19NfISMzMHzMm0fVqeVpg3fJe0ahMcr3q7Jp3fMD?=
 =?us-ascii?Q?A6JkxQMBD+VFYkOYsjKfk7UQV4/T7zE+EPJAjGeYdSPh5+YBowsJy4noH41C?=
 =?us-ascii?Q?vdBtyxljXE1pTFz4OZnc5Biy/L2tNGVNxxFFbnSuFrZL93FIgB/k1Ao29PQB?=
 =?us-ascii?Q?vea2F3RjK9wybsCs0QzGlk7SXicXrY5t7SA6KxrPp8aBUTtQuSUQj/tb5VKY?=
 =?us-ascii?Q?UXSANgn8n2i+c1mKl3wg2nDNqdW/VV2UxlnoNBaiJW25HJ4WWCTjuxfk9FUx?=
 =?us-ascii?Q?ntwML/g63gsHcsEL3Ob6rJjryFdqMDRf9H4iK9NTful0SgfnPM1KRDpnAi/U?=
 =?us-ascii?Q?lm0JC0+zODsCEWXdvY8A3wDF+d2qWQzFxQYCmbg0Lun9zWfJdLud4GhCAkFc?=
 =?us-ascii?Q?wVRmSowzwQPmi/DGpyzdJiuH/KldjtaxnYawn3gMefochVPB21ESDcqiJp2b?=
 =?us-ascii?Q?97omLKVM8KcNk3KI560/H0sOITlyzE5Ghrnw3I5csArDp6k9MYfwrx2zoL5z?=
 =?us-ascii?Q?O0+oVWmKlBE1PuqXbb1ZOG7cQf5CEii2C4AZxqcepGfLkM2hTEnzIm8zkrsG?=
 =?us-ascii?Q?zayeKMcZepk0ZyDq+zIv8N8PZVqnkzfxxznbpLxN2Xh5dyIo7D3qoMjWMA0G?=
 =?us-ascii?Q?U7o4o27m1OX2kRvnfKjX/cVYGt6sOvAs0wUoLvPQr1X0kY075k9FpWyIZijB?=
 =?us-ascii?Q?7qYcrpZoeUTSFh38/eBQ0FiyopM+c597tN5Lx0OUW6J3i+LTYOPgpFi5MWmX?=
 =?us-ascii?Q?pawj40kiZcigmC7YIVsaN2wkneVzfvKIBgF9yi4Uyi0ZF+s6H/t3dYieCGcb?=
 =?us-ascii?Q?xB+zRKP6pkRztsML/rQYM133VCJs+GaLJhXhbsVEspT8ULjY17/9ZtZR1bXH?=
 =?us-ascii?Q?Z5UHruiu7vJqlcEfCxmTwpQPQA8XUPwMa8K9cPi5Vl+frbKQ7OM1S/gicZ+P?=
 =?us-ascii?Q?u+bKWxyHsDfP+xwrUtHL+meJJ1XOEU9mTLrWgw37lm3DE4DqLxtuGACvnqCa?=
 =?us-ascii?Q?r91ZvO48rwMCOxbgF21sbvGrc7usPuXr2t4l6iqHaDO4H6xW8anRbh3TNwDT?=
 =?us-ascii?Q?PYltxSCgmiSi+uHfE9pLX6D4TqVSuoOqDPpYRYsO1o8nyabOwWDY41YPqYbW?=
 =?us-ascii?Q?E1h6dJyKbJROOCQvhwOfiIt18YGHX1CL3ZWvUC6gGSdzO9OiwvdWqYCC6Rnw?=
 =?us-ascii?Q?UP0y15VqSxvV8yVZ5p2U9sZ6jrGXFQrZPDRTVGRhHk2Fk2Va2vs1xK0g1Oqo?=
 =?us-ascii?Q?R4mX/fCESSgLlxcaos4RTT563tUlMVrXaP22?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b399ac-bf80-41cd-fefd-08da074dc625
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:06:24.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVqA/DR83PAvx5JoNurWg0lnibXBTLq74SHSVD/vpOiHVyOK5VxE9A6YUlTeApy9TSDiBY2jMYcWW6eX6X4CCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Wednesday, March 16, 2022 01:30
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Andreas Noever <andreas.noever@gmail.com>; Michael Jamet
> <michael.jamet@intel.com>; Yehezkel Bernat <YehezkelShB@gmail.com>;
> open list:THUNDERBOLT DRIVER <linux-usb@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
> IOMMU is active
>=20
> Hi Mario,
>=20
> On Tue, Mar 15, 2022 at 04:30:08PM -0500, Mario Limonciello wrote:
> > Historically TBT3 in Linux used "Thunderbolt security levels" as a prim=
ary
> > means of "security" against DMA attacks. This mean that users would nee=
d
> to
> > ack any device plugged in via userspace.  In ~2018 machines started to =
use
> > the IOMMU for protection, but instead of dropping security levels a
> > convoluted flow was introduced:
> > * User hotplugs device
> > * Driver discovers supported tunnels
> > * Driver emits a uevent to userspace that a PCIe tunnel is present
> > * Userspace reads 'iommu_dma_protection' attribute (which currently
> >   indicates an Intel IOMMU is present and was enabled pre-boot not that
> >   it's active "now")
> > * Based on that value userspace then authorizes automatically or prompt=
s
> >   the user like how security level based support worked.
>=20
> There are legitimate reasons to disable PCIe tunneling even if the IOMMU
> bits are in place. The ACPI _OSC allows the boot firmware to do so and
> our "security levels" allows the userspace policy to do the same. I
> would not like to change that unless absolutely necessary.

Actually I intentionally left that in the RFC patch, to only do this based =
off
of tb_acpi_may_tunnel_pcie, so I think that should still work as you descri=
bed
if boot firmware turned off PCIe tunneling.
