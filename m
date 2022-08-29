Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5C5A5675
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiH2VsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH2VsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:48:12 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C396E85F81;
        Mon, 29 Aug 2022 14:48:11 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TLlpVl007978;
        Mon, 29 Aug 2022 14:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=LtZPjwZkS4Y7hem2mDxxl8gMPZrRK1DQkuwDIhGaywU=;
 b=t3X8+mAVedVmO/Oub+RQ/1iHKKPnrCvdVqPi5rji1vy12XLOiNOtn7hC5sxA223GnhM3
 qRnrvJ0OTBZ+WY5uuNsAXD2Zgfh7FXmX6D2FH5yGkIrEW9g3YOWpLXZQ35PxuTJWgf65
 THyuTbroltfe/8xtBNbON6WhY2GYQhD1kNZ2fGfN080vCK3JKD3zu/Gl96i0A/4WJExA
 LD5/iRzX/Ay99mba35Msy18UK9XS6bRH45rZfSMdOQjr89Jn0v+i9apTHF3f0u+HfXmS
 Cj54TvUWNcDARgRZpuS7LvApxv1ygTzyLv4yMdVEqUye4xOHY/T9irTpZLYnqU7+2haK /A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j7jh6k24n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 14:47:50 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AC31540042;
        Mon, 29 Aug 2022 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661809670; bh=LtZPjwZkS4Y7hem2mDxxl8gMPZrRK1DQkuwDIhGaywU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GVrbUY5WGQxvkcNcyxEUZ0yxNP6+54Ty9EToj8FLze2fyMQctUdsv4ma0DOCrrT4g
         BifX4n9S2kTNVByviPAEYl5rA/kdfq8RT+bkZWohksy7l6IbQdqcPu3xABuaZILWGd
         mPZawz92G0DksjQwI/82AMrFbtl3QgjAL0I6fSG+LGVN+s0O09onuW3nkrTrfcw69B
         /NSj7Ls07JLa3UihhPbz1VnRPsWmlD1TdP2UKZhWDqmMCjuSOLypRfpw+/0tuflwQO
         SUdLJ+QAldzD8F0OxESOAImI1FZAWAz9V4EQsJEBwIoKNc/ouo+NoO+ZGcz0vCHjnP
         mFXkrhJpyuLhg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5B3C4A006D;
        Mon, 29 Aug 2022 21:47:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9AEA580199;
        Mon, 29 Aug 2022 21:47:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KsP3wk0Z";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOuPgmsVHEZqAC+tkWkuCSDBSgxrpU05KiJNLYXEZb5ZWJVLFnUcM9WyDcuE2KCPp4rsrSz7AKwU+EBVH61VpUqVQho6zz5aCZXzDtYrBxjRRUdzRMyh5D/lnFFCBwEHAkPxv7MwX5BXvuRQMXA9GsQtPLhIHRZNhSEnoFJ4jE7U+wYovfwONyM+WHpUqRMGqtu3gOshZSgRfHFR/NqhIc5T//YKeV5fVkLxFD428D/LQGadI5wzXxhrNif1XXNKKomPR+jq2X5IsEqbXlQFqOKk7RcDVPutJ8+LwfB2tw8bHQAATH37rNqCLsBeNHTU0gSkm0OjLd/H76fEe0XWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtZPjwZkS4Y7hem2mDxxl8gMPZrRK1DQkuwDIhGaywU=;
 b=PX6Gp80K6KkEvWsW7rTlXtssi+RRDIaPLpeTigPxt4CH3ktKiaaabKRJqFfnssITFyN5NsJLKTi2Zaa9g1N8qgF2FMoU/lOEcqoutsbJvU7vo4XJPbGuBr3MmcCxV7kDoadejJd2lwh/fVchHFYgBzdCRWRvW6wYzmQmv+CKd9s7CeOCscawxUznwApQ8mgjzHpr/N4wEHyrP93mSAw+nQxktuKlgiTKRY8xEbCoLY8gy9ay2qG/8B7ahm6ugEcTJSxjAOVrasUPHxtHkKHeW/dTGhcI3/4y/j/NhaOSORLBLfjIXNQ9SYqFltFtyqJyRU07jP6Wq+e4uEeVucSRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtZPjwZkS4Y7hem2mDxxl8gMPZrRK1DQkuwDIhGaywU=;
 b=KsP3wk0ZRYHi6kxU0wbSEutbPk0kU6DN9mV4H1V5SjONKtXjBK53O1RowFSHenZyhoPjtHd79Zrv50hKQOuMS57puG+F3450guPipepWX/55ZwCzMbKVyak8uO7rM2DVvu4YSOmhI1LYY9FeDhh4hT1dEzjLih9iZhFI74jcB14=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB3625.namprd12.prod.outlook.com (2603:10b6:5:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 21:47:42 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 21:47:42 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Thread-Topic: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Thread-Index: AQHYmw6u7mupoIR4k0KWMCBmFxWkbK3A/P8AgADCsQCABMsNgIAAIQ8A
Date:   Mon, 29 Aug 2022 21:47:41 +0000
Message-ID: <20220829214738.g4sazbxapgmlyksa@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwhvmpdbG8WXhhZ0@linutronix.de>
 <20220826183732.vxogtdlwqiqbcg2t@synopsys.com>
 <Yw0YP1qUYAw6inMJ@linutronix.de>
In-Reply-To: <Yw0YP1qUYAw6inMJ@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f701325b-7c80-46c7-fc15-08da8a0819a2
x-ms-traffictypediagnostic: DM6PR12MB3625:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSpYKMj+nHTUemnHxn4jH3o/bQEidekaX9YeIrTOecEJg+PhC6yy2190Eqd2s/1dARm3F1tI8gF/w+E3aIK+HqfXSm2aXnt/l+gH1pxaOM3zJNFwbSszc7o45JKeyu8Fot3DJVZiXRPA8DFxXoSkACB6pr090oVrj5qzW4TV8kF7+qT6q5zJpeiS/zH5WvsfvadRIg6fYMJMQWLP/c8f8C7kwMBuXi46nb+ke8u/ZiHjCE/22ZrVIufSNk8jAV/1rWwrPVBhtow2meRCSLnEbPrpJlE2/Xs8tF/6j+PIdxB3HmoOkJSvOeLC9EOcI/n6x8TPPa3EVa0Zn5o12VjsrOF67peFkoE2amACPEzs5VLJdLWhQNwPbvanhyANt1YWf6PeAfbBTXZpVTKi2WerRIVErIKFAwT3SFupc+Klw/ptil1mNDbJ6wuAnXPzwHFYg+j54mOaOLuT2Swsn8BeObJMUNc6JZaGCm9ugS7ncyxupIQIRX6hKOw7wa+jc6g43Gco2kzbJnuG9IKzPDJoci5sPAjgTntL/dsTlHS6tmh7GzLECZtw32p5IMqBqtXvXhSLmUWnB6lTMxQbs6etYPZDcWVa1DxqVj1SU2Gim0B6qnGBI7KlvxpE+MlMxFwiDecbmVQmcuWbrgSTRAYFO42VRnJvdySTuS5pMKBhNUCy5jZ99CmIn2+8AwBi3deKD9u8e59PYwiVLhEYcEWX8XNh3bknceu54CpR+wjbRKc5IJxW9UVQmNnUrHwiGC7VY4SqUAgQUJGnurQoytdmAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(346002)(39860400002)(8676002)(64756008)(66476007)(6916009)(66946007)(66556008)(76116006)(4326008)(66446008)(54906003)(316002)(38100700002)(5660300002)(2906002)(8936002)(122000001)(36756003)(26005)(38070700005)(6512007)(53546011)(86362001)(6506007)(6486002)(71200400001)(41300700001)(478600001)(2616005)(83380400001)(1076003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk5Lc2xzZlhOOFhMWXVsSHR0NVJiSzRldzJMMnJsTjI5K3hna0IxWGJPTDRv?=
 =?utf-8?B?SnpMcWhHcjhaN3BSenRSZmZYU2N0VnRzYW41QnE5VFc5M0tsRGF6U2s0SFFj?=
 =?utf-8?B?eWxsRy8vVGNld2pmVWZLVjVEcHhhZGpxSUkzbmpsVkIxK3I5U0ZsR2NkNzdy?=
 =?utf-8?B?N3VRbHZJWHgrSHNkdi9OMGxGTndDV1MxMFpVRUdvaE1ZTmxQMFVkZXlsc2d1?=
 =?utf-8?B?c2FBVndvbUQrMkNXY1VMRHQ4U2d5UE9VNFBUUWJ5Zmp6QnZOdFRYdHUwQndM?=
 =?utf-8?B?OXc5UWQ4TGZwQ3Nnck1QVk1GSW5VTUpaVG5LRW5mb2dmdUJwK3RydkpNNHl0?=
 =?utf-8?B?UDlZQmZhYTVyem95OHVPaG5XZWNQNVIxUk9SZnMvcUJTSVg1RTFmUnhzMHlm?=
 =?utf-8?B?ZVF6V1pJL3NDeSs1cno4bExua25xNjlHOHlsSUVpQlFBdTVCU2JhVmNBb29G?=
 =?utf-8?B?dGR6UFVlTElRdEg2TlpQeXU3dTZoVms0UWh5ZUdORFZ4WG1FQlA1dlc4d1FD?=
 =?utf-8?B?RVpnanNVeHYzUUJVeU01dXFndFVPanU0L0IzVEFMRkMxcWpNajRJcTRrN2JC?=
 =?utf-8?B?eWtJZnRCZ3BtR0VKaC9HU09TOURvWWZDeFkxV3NsMHh6Qy90YWZuMzFXcmJk?=
 =?utf-8?B?d0FUMHlGc0J1R1hOWmptZTM3bnR2cVoxaFVpK2VSQjdtNnlQYU5KYmU1Q25w?=
 =?utf-8?B?aGpWeDlpbEJOTWxTSURmSjdoQ0J3Uk4xUHo5Z0lvMTdFZE8xZW92UWFhNFBG?=
 =?utf-8?B?TGdVY2VMRW1leUN1Y2FBQ2l2WXZZNDlrQ1oyeXRic3A2eVlZZk9jVm5Va1pU?=
 =?utf-8?B?V2xJZThzdkhyaVNzeVJCYmFHbDU2MndlQjRIaXpwK3Q4Nm10Rm5Wa05SUldt?=
 =?utf-8?B?dm9qOThxM0JUZWRSQ2g5UEU2emRNT2xrMUdYMXA3ekdCZ1dNdGw4UkdHeU5T?=
 =?utf-8?B?aU1MWXdUUmVUT3dCcnIrZUl1b1c2WkVETjE2aHlJbDJFdlhPaDBuaXhrUFNL?=
 =?utf-8?B?bWE0QVhDNUlndmlabjJ3a3c1NGZzZS8xVXE3WVdCbEYvZmwwQ2tTenM0T3Bm?=
 =?utf-8?B?V293akY4SzEwSGxvbnpKUktjRUlOWXFkZ2dBdjlsRmhUcWJtKzlvUFkreTZJ?=
 =?utf-8?B?ZEhDZngrRzByY2xWdGIvY3MxUTlJQ1Rlb3AxcWtLNkg4SU5LbWxPMnYzVTFU?=
 =?utf-8?B?STZZQnFGWWY0WVVRajlvZ01WQXFObW85cHJoN0hCNkUyZUx2T25EQmphQkg2?=
 =?utf-8?B?ZEZrNUlQZmxNd2FTR2lqdzBoMytUcGFiZlhtTjY5ZWxjOGJzR1I0T2NEMi9S?=
 =?utf-8?B?VVI4eTNHcDYrQ2JsTks4MWNldDdhZ09OaHM5TWdnVzdZRDkzVlZKbTlHQjd5?=
 =?utf-8?B?cDlJakxtNjZTMVBkWS9vRERCbWJxN1JpVy9CUktpdEJCa2NhTnUxY0R1WjFk?=
 =?utf-8?B?VHBYbWsrQ2E0eGNRUmRSSmZnUG1KanhGbE9MWEtuZGVtNXVGUXkvKzg5bklh?=
 =?utf-8?B?VitidHNBSjF2alVaQVB6eWF0V1QvUndNd0MrTWt3bnQyZWcyOWw2SkVpamhN?=
 =?utf-8?B?cGlKa1RqUEpFdnBVdE9kNU9GRFUyMmJuN0s2N1VZWFQ3MC9sbUZHbW0wQzhK?=
 =?utf-8?B?RkQzc2pHRnpJTlBxYkxvejhYZ2crV0VLOWpIRmJHTWxmSC84cXJaMlMweWhz?=
 =?utf-8?B?aHdkRGQvZURheXJ1ZExSVUZ3WWZ5VEtHQTY5bjJIVzgwTWYyTWxBL1BaTU5I?=
 =?utf-8?B?bDNzN0hlWGtZa0dvOTRTeWNBb2JiSXpPTGREWG9mMDc4OVN5MXBFRjB6K2Zn?=
 =?utf-8?B?Y0V2dkdrUzBHaHZ3YkFKdzRVUWNTYVlZblNqUExlbWYrWXNLMTFWTkNnaFJa?=
 =?utf-8?B?QlZCOGlGeTVKcXhaL21jSnB2TmFPb21ScE8wTjJKNit1R3lzTzZyMjNMWjdt?=
 =?utf-8?B?eDZqbWRyS0hxcTV0bEdVenUweW4vK29iR0d0cllOYWY3cXZ2dU1XeDNNRUVJ?=
 =?utf-8?B?YnpYS2ZZNHBGcTc3OXFSVW9ibThFeTVBQmpIbTQwbThZeDdKbHIyeTlRTkdX?=
 =?utf-8?B?bmVtQzdjaFZCazNzMUpPS0NyU1N0R1JQK040aFBrNEFqN3czcVlUSVR3RzVm?=
 =?utf-8?Q?/cKOTLHvl/QgLmAh3Lhf7P+U5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EB554B50245754D8447AA19391B0149@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f701325b-7c80-46c7-fc15-08da8a0819a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 21:47:42.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bp8v1axIXgMo2JSGRWe7l9e+Jh3BL7W7b5TqIkXdTSn/JwVl5fRl7DTz9riYabWPp87IiSQH68LtjX6vLhGVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3625
X-Proofpoint-ORIG-GUID: YKBjvNRbK4svCPWeUpMUV6mqdBaNVN3_
X-Proofpoint-GUID: YKBjvNRbK4svCPWeUpMUV6mqdBaNVN3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208290096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjksIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDgtMjYgMTg6Mzc6MzYgWyswMDAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IE9uIEZyaSwgQXVnIDI2LCAyMDIyLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIHdyb3RlOg0K
PiA+ID4gT24gMjAyMi0wNy0xOCAxODoyNzoxMiBbLTA3MDBdLCBUaGluaCBOZ3V5ZW4gd3JvdGU6
DQo+ID4gPiA+IGluZGV4IDZmZWE4MGFmZTJkNy4uZWM4M2YyZjlhODU4IDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0KPiA+ID4gPiBAQCAtOTU1LDcg
Kzk0OSw3IEBAIHN0YXRpYyB2b2lkIHVzYmdfZGF0YV93cml0ZV9jbXBsKHN0cnVjdCB1c2JfZXAg
KmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCj4gPiA+ID4gIAkJCQlzZV9jbWQtPmRhdGFf
bGVuZ3RoKTsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICANCj4gPiA+ID4gLQljb21wbGV0ZSgmY21k
LT53cml0ZV9jb21wbGV0ZSk7DQo+ID4gPiA+ICsJdGFyZ2V0X2V4ZWN1dGVfY21kKHNlX2NtZCk7
DQo+ID4gPiANCj4gPiA+IHVzYmdfZGF0YV93cml0ZV9jbXBsKCkgaXMgaW52b2tlZCBmcm9tIGlu
dGVycnVwdCBzZXJ2aWNlIHJvdXRpbmcgd2hpY2gNCj4gPiA+IG1heSBydW4gd2l0aCBkaXNhYmxl
ZCBpbnRlcnJ1cHRzLiBGcm9tIGxvb2tpbmcgYXQgdGFyZ2V0X2V4ZWN1dGVfY21kKCk6DQo+ID4g
DQo+ID4gSXQgd2lsbCBhbHdheXMgYmUgY2FsbGVkIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBh
cyBkb2N1bWVudGVkIGluDQo+ID4gdXNiX3JlcXVlc3QgQVBJLg0KPiA+IA0KPiA+ID4gfCB2b2lk
IHRhcmdldF9leGVjdXRlX2NtZChzdHJ1Y3Qgc2VfY21kICpjbWQpDQo+ID4gPiB8IHsNCj4gPiA+
IOKApg0KPiA+ID4gfCAgICAgICAgIHNwaW5fbG9ja19pcnEoJmNtZC0+dF9zdGF0ZV9sb2NrKTsN
Cj4gPiA+IOKApg0KPiA+ID4gfCAgICAgICAgIHNwaW5fdW5sb2NrX2lycSgmY21kLT50X3N0YXRl
X2xvY2spOw0KPiA+ID4g4oCmDQo+ID4gPiB8IH0NCj4gPiA+IA0KPiA+ID4gd2hpY2ggbWVhbnMg
aW50ZXJydXB0cyB3aWxsIHJlbWFpbiBvcGVuIGFmdGVyIGxlYXZpbmcNCj4gPiA+IHRhcmdldF9l
eGVjdXRlX2NtZCgpLiBOb3csIHdoeSBkaWRuJ3QgdGhlIFdBUk5fT05DRSgpIGluDQo+ID4gPiBf
X2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KCkgdHJpZ2dlcj8gQW0gSSBtaXNzaW5nIHNvbWV0aGlu
Zz8NCj4gPiA+IA0KPiA+ID4gPiAgCXJldHVybjsNCj4gPiA+IA0KPiA+IA0KPiA+IFNpbmNlIHRh
cmdldF9leGVjdXRlX2NtZCgpIGlzIGNhbGxlZCBpbiB1c2JnX2RhdGFfd3JpdGVfY21wbCgpLA0K
PiA+IGludGVycnVwdHMgYXJlIHN0aWxsIGRpc2FibGVkLg0KPiANCj4gYnV0IHlvdSBkbyByZWFs
aXplIHRoYXQgdGFyZ2V0X2V4ZWN1dGVfY21kKCkgd2lsbCBsZWF2ZSB3aXRoIGVuYWJsZWQNCj4g
aW50ZXJydXB0cyBhbmQgdGhpcyBpcyBub3QgZGVzaXJlZD8gSSBfdGhpbmtfIHRoaXMgd2FzIHRo
ZSByZWFzb24gd2h5IEkNCj4gZW5kZWQgdXAgd2l0aCB0aGUgd2FpdCtjb21wbGV0ZSBjb25zdHJ1
Y3QgaW5zdGVhZCBvZiBpbnZva2luZyB0aGlzDQo+IGZ1bmN0aW9uIGRpcmVjdGx5Lg0KPiBBbiBf
aXJxc2F2ZSgpIGluIHRhcmdldF9leGVjdXRlX2NtZCgpIHdvdWxkIHByb2JhYmx5IGJlIGFsbCB5
b3UgbmVlZA0KPiBoZXJlLg0KPiANCg0KT2suIE1heWJlIHdlIHNob3VsZCBtYWtlIGEgY2hhbmdl
IGluIHRoZSB0YXJnZXRfZXhlY3V0ZV9jbWQoKSB0aGVuLiBJdA0Kc2VlbXMgdW5yZWFzb25hYmxl
IHRvIGZvcmNlIHRoZSBjYWxsZXIgdG8gd29ya2Fyb3VuZCB0aGlzIHN1Y2ggYXMgdGhlDQp3YWl0
K2NvbXBsZXRlIGNvbnN0cnVjdCB5b3UgZGlkIChhbmQgSSBkb24ndCByZWNhbGwgd2UgaGF2ZSBj
aGFuZ2VzIGluDQpwbGFjZSB0byBrbm93L2d1YXJhbnRlZSB0aGF0IGludGVycnVwdHMgYXJlIGVu
YWJsZWQgYmVmb3JlIGV4ZWN1dGluZw0KdGFyZ2V0X2V4ZWN1dGVfY21kKCkgcHJldmlvdXNseSBl
aXRoZXIpLg0KDQpGb3IgdGhlIGR3YzMsIHdlIG1hc2tlZCB0aGUgaW50ZXJydXB0IGF0IHRoaXMg
cG9pbnQsIHNvIGludGVycnVwdCB3b24ndA0KYmUgYXNzZXJ0ZWQgaGVyZS4NCg0KVGhhbmtzLA0K
VGhpbmg=
