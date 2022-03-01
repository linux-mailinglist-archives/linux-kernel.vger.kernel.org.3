Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3487C4C8946
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiCAK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiCAK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:29:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE425D66A;
        Tue,  1 Mar 2022 02:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6RBrRcUPhHjJNj9I4djKpUnTstz7a5lRl3fU+111Z8frf8fCPrZbO0DBNve9r6BmS/Rt5cSyD6s091WvV/XXMRIWhLQOyi3tjgk6whrqYu6L2l7j1KFqszv7y2hSpzfh0yUe+xeQsnV5RqEEazzT/oky+3/r1zyTWgnjGjGnFyunu/KYBAUsZEsVuPDWgSPI1yncc30HiFEAaozFROTQgQVhyAtX4BvZksbHB2+eKlsZ6FS8bOPfQns8Kn/GHFZi2J6G59YnZh9NYo4QD7H+aukmj64Za2A0Qq5Sfj91yjNPxtT9Jtk/cAyYflk7Xedle6vrTbXRQDPN5VOP4VscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR0NNcKXNDo0GxQHTnUhAtJKL4htfGs53Voezs6MNFQ=;
 b=KPXzNiEFgGoyXXo/NvBTgrRaQsvZEOKRFnCAcl5WfNYU/b0Jx1HjPVhPbktqMWasl0w1EuJqBMTIXXrS3POpkWNr3fNwgR8mBNjGMAPBZEfFVPdogGVgQadp9wRAXqdW8bTiiWurN9S0joaBCt+9tpqhnSbQV+STMCmRJcgrYYQr+ObcJH65ZAwgCv6K64Dj3fWgnob5wlCtwOTNxH9UsBc2i3EcmxA5x0S6samRwIT02cbiJ734q1Qnh8w3X1No0Aw14+ZFTQZ5IHn3Ec2X5/UE0x0K238VFMMUZeHOlO2Rx4dGqIhYAPAC45q0qnQ4aDrcYad9p6XH7k92fxXbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR0NNcKXNDo0GxQHTnUhAtJKL4htfGs53Voezs6MNFQ=;
 b=dw4X6RoqAjOa3lGsFi4gG+dWCo5V0orFwnFqH8h8cAYJwTg48AtYZWY4V56Tz1SN8s8CKfQGZFAXO2QKpZDgoh3IqctU2iZFE+Z8OcPRxj7+E6b7/n+8ZLAaVkWYbYapfvpmICMwfYVU/R+ablemPobKn0tSM39J7Ps1VGoEIYVyj7WYaCeUM5+6yOpJi3i3vW3XXUkjGtWbExn8Dmj1X0wdEoukMuw75xFnCTj29cKqGfs5qgPpVN05Q7NfXw71C4fysDZ9IqaCgzVff/2566zftSneCQ91qSngZgpM7lQM7BxkuBRA77SF8GcuRdtzkZoSiPrskwk9fSzuqp1hQA==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 10:28:49 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 10:28:49 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKhd7AopZ8pn1EUiip/DzNcJli6yoz4qAgAF/L3U=
Date:   Tue, 1 Mar 2022 10:28:49 +0000
Message-ID: <CH0PR12MB50892722DB1E7ECA5BAC629AAC029@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com>
 <2ef7da52-d8ad-05ca-bcb6-06bd6bb6f9d3@linux.intel.com>
In-Reply-To: <2ef7da52-d8ad-05ca-bcb6-06bd6bb6f9d3@linux.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6850a4df-9066-c94f-ac23-5820aea08e5d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 626110fe-cc74-4b73-9294-08d9fb6e4673
x-ms-traffictypediagnostic: BYAPR12MB2680:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2680FFFFD26CD0BACF4B4623AC029@BYAPR12MB2680.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7L5/XZZwx58QJmXCS860gF4waBKMsasYnphisCmiUpGayBX3P1dLWp6c2Ul7Kcx+9SoA4/Bss0+1TeL5h79GaQitSvdYwFpY861H/uJ+rDpSol9Yt5T48o+cF/X4e2fFXBM4JJVkZy1+XKTgSsIDyNWXb5TjeIyfUpTgfzyOoLGJ5YD+naty64/zGVxhgnPtfGfP92WqffGuJ7qC2r/lJCKek/P2WnjxWYU3Pp3Rb9xkTf5jpapNIW4zEzr9Ib1U1fTcFAlUKCpIAq7+Tcq71fZn1yaT69/5CXijZnt8CG9WS/EXWh27Gsk2vagyX2iLwfsAvQ/XZZr8g5YesTWwYYBBjgVjP+lsr6Ua1ya1EvUvhp/wK6F2advIrIo4Erw+L+8DeiB4MzvorGhIngTls58bPtnrGqa6vma5jBmvEiuRxIo4cnYflWyxjiYpWvk5/TBq5Ks8F9sj86uU7MqVO30plQ1j2/fLjl7p3rggaFFDaNJSLapb/Jo4tmeFV23nGPzK/f7JD98Sqo1LB8QDodANF9AXFxRDVWksWYCIPNjbS2E0lUp45+hceXnN7TmEEgMaAlXvQW6GTrl358q2YGhGs0uaUBPTX5R6ZpeqsTQVh3FWOmCfhEq9v1YlQtMozpS5PxWuq2UDqg4UL/jVKSNZoZQmFBTkGH/jf/Vzn0w6pfikezO+Sm6EC0pW4DHFvOf7VFfaizIlUgUkBWuJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(4326008)(33656002)(83380400001)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(86362001)(6506007)(7696005)(9686003)(55016003)(91956017)(508600001)(71200400001)(186003)(26005)(316002)(110136005)(54906003)(8936002)(38100700002)(122000001)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8A242PNRmZw1eY+ntlXU8jN2IJtgpmw+Gh0GVvwxGqm+SMOfQh6GwuJo0o?=
 =?iso-8859-1?Q?DF/w1x0C9sUiUfIJwyz3ndKhYnkT/7qZeueEUsY9CKRb7xsH/KTa5wDTZw?=
 =?iso-8859-1?Q?kxjIjsqzQunSSH+ICXnZxo95RH8QV/QN4k6CiYodUXA5qZm0oEKWtBAxlb?=
 =?iso-8859-1?Q?BSSWnZFKmQlCM3/8nVwJNlHoI0kqtZDRCiyCf7zZkEe+hrhYUW2al0eSus?=
 =?iso-8859-1?Q?Y1/me4ydAZBO3OuMnslcx3RH67HvLgK1E7IGuxLoF3J93lLlmui1ahWn65?=
 =?iso-8859-1?Q?ZwlFWZutjrQKxKRHzuqfI5Wpe0vW8NuLVe06bVotRaDKHtU8E8F/MAwUki?=
 =?iso-8859-1?Q?/a/1zieZW81/mAPAKcguRVHUJirg7whescxfuWgoUuZnrUxbY3rn+jkAk0?=
 =?iso-8859-1?Q?BY7FiyzdKN+FWx1INwkzWP4zrunkGueM9lgpcLVy81OEskAMZo2mZbe5aQ?=
 =?iso-8859-1?Q?MkEIQQe1gkGVrp2Rg1auSWMGiAj8+7iXAFW3dti8Nt62cSFDMewxMSaJNa?=
 =?iso-8859-1?Q?0l1PH49BVQzSBeFibxHoTEJspe5NnHIbssTQpQTCNYFHt8qpxiT0gYgmK0?=
 =?iso-8859-1?Q?ghN3DACkHIr0fTpFR02Mcv2Hy336xUYCE72upDt9OZ51ACA9XZXBMm6h1b?=
 =?iso-8859-1?Q?4CWQ1DsV2ewITrU6UWFCNWdQVJoibcc4/vs7TNTUz3EochqaQEfl5Tey+0?=
 =?iso-8859-1?Q?lJH0koeT7i/P/n+jE0iSCgynMtcXtSLxKsjrO60SCj+ywz+kzDBZk+oq5i?=
 =?iso-8859-1?Q?BV3QB/QIETh736pwCH2xmVd01ANRuhg9C56aSac+QEj8OT94P0L7eXOEcD?=
 =?iso-8859-1?Q?inSSz+Ll0cahgwi5AaT7BaWRXAHu4B6xeiA5IT2mJ1jIUOqdUtEpZ6O5CD?=
 =?iso-8859-1?Q?ZzVDWnQUYtO/pg4E3KbxE9T/+W6IEb68HoxFEKPnlq9PbEg9LfhvUOKN+d?=
 =?iso-8859-1?Q?aDpETtafva6lcJNrcBBHsgyra1x7DWqUGilLbnWCGz4oyaUjRHFae0Dx5Z?=
 =?iso-8859-1?Q?7VbiYpPWQ5bmxXjuElsIws/3As6vvu+5sMD2pfingmIFLfTkBVcM338D2N?=
 =?iso-8859-1?Q?MjPDhL4mgMDCB1WdgixCFKyTF68FhsZstLWpQbqjzD7gpeSOiThvRjJWil?=
 =?iso-8859-1?Q?JyiCNme3azG6qz7YQ4Q0kAcaWtX84yGBGbYSre923jCOPMUvNWg7XHa7re?=
 =?iso-8859-1?Q?1lOspNjtPUcnAdZkZxdVesuMoeqov1caWklUHzFnSQb0gQXoZeFdASR4KA?=
 =?iso-8859-1?Q?lpbX5OnecyIIk+ixyJnHBH0Yawp4WAWREVGdZzfW35U1VeYmKFDAZMU8Jd?=
 =?iso-8859-1?Q?6mbJEihJT6j2PteGHJmw94VGNVQaDO4yTL42mhciEUWyeXZQgbKL+pd72V?=
 =?iso-8859-1?Q?5rjWi5Qu/ejJTcyC5jmeQAMqHo2OSY0RhvPPhRs4LiKA8YzqWeOp99qJOo?=
 =?iso-8859-1?Q?u6pk1n6TUDHapXbaXO9tM+w6JkuK0Z5DnZfdwayl9emSDhwGk2bf14q1h0?=
 =?iso-8859-1?Q?1sWrc1UowkyBsPpocyUmU2IGYAXpSoCtWxx+b/uVef3SiNuH4DOY+8DtEB?=
 =?iso-8859-1?Q?9fXdxB02OvIIR15q+0FH2s5r8tAtUliDiweSkvflEK1kbODbYPUm2rIhF0?=
 =?iso-8859-1?Q?Ri9F6Ty/9dgCdLJzTAWW3sl/bxfbwFBheIjOBGsfsSl2yT+bqL1Q8VAw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626110fe-cc74-4b73-9294-08d9fb6e4673
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 10:28:49.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAkVWiYehTBj4jvyGgjuI4ALOlgRM/xOQz/bNUdwYRTMbJM1A4juc5WrGOdsI3d51LXFWt360f9FH5YiijHqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> USB2 resume starts with usb_hcd_start_port_resume() in port status=0A=
>> change handling for RESUME link state. usb_hcd_end_port_resume() call is=
=0A=
>> needed to keep runtime PM balance.=0A=
=0A=
> For normal usb2 port resume the usb_hcd_end_port_resume() is called when =
resume=0A=
> has been signaled for long enough in xhci_handle_usb2_port_link_resume().=
=0A=
>=0A=
> This is also where driver directs the port to go from Resume state to U0.=
=0A=
> Port can't do this without driver directing it.=0A=
>=0A=
> If there's a failure during resume signaling (disconnect, reset, error) t=
hen=0A=
> stale resume variables are detected in xhci_get_port_status() and=0A=
> usb_hcd_end_port_resume() is called.=0A=
=0A=
> I do now see a231ec41e6f6 ("xhci: refactor U0 link state handling in get_=
port_status")=0A=
> does change order of checking and clearing stale resume variables, but th=
is should=0A=
> only happen if the first port state we read is a fully enabled functional=
 U0 state after=0A=
> a failed resume.=0A=
=0A=
> Could you expand a bit how this was detected?=0A=
We observed the racing issue when usb2 device-initiated resume occurs in sy=
stem resume.=0A=
If usb2 host-initiated resume for system resume directs U0 before xhci_get_=
usb2_port_status()=0A=
see RESUME state, xhci_get_usb2_port_status() will not finish resume proces=
s in=0A=
xhci_handle_usb2_port_link_resume(). Its scenario is as follows:=0A=
=0A=
1. System resume starts. All driver system resume callbacks get called in o=
rder. XHCI controller=0A=
    is resumed by xhci_resume().=0A=
2. USB2 root hub is resuming. hcd_bus_resume() is being executed.=0A=
3. Before xhci_bus_resume() is finished, XHCI driver receives a port status=
 change event for =0A=
    an USB2 port with RESUME link state in xhci_irq(). XHCI driver starts t=
he process to resume=0A=
    HS port for device-initiated resume.=0A=
4. In xhci_bus_resume(), host-initiated resume (direct U0) is performed on =
the same port that is=0A=
    resuming in step 3 in below loop:=0A=
=0A=
                if (bus_state->bus_suspended) {=0A=
                        spin_unlock_irqrestore(&xhci->lock, flags);=0A=
                        msleep(USB_RESUME_TIMEOUT);=0A=
                        spin_lock_irqsave(&xhci->lock, flags);=0A=
                }=0A=
                for_each_set_bit(port_index, &bus_state->bus_suspended,=0A=
                                 BITS_PER_LONG) {=0A=
                        /* Clear PLC to poll it later for U0 transition */=
=0A=
                        xhci_test_and_clear_bit(xhci, ports[port_index],=0A=
                                                PORT_PLC);=0A=
                        xhci_set_link_state(xhci, ports[port_index], XDEV_U=
0);=0A=
                }=0A=
5. Then, link state of the resuming port is observed as U0 in following=0A=
    xhci_get_usb2_port_status(). xhci_handle_usb2_port_link_resume() has=0A=
    no chance to get called on the resuming port.=0A=
=0A=
Thanks,=0A=
Henry=0A=
