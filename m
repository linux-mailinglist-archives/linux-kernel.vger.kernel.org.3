Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425924C3ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiBYB0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBYB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:26:43 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E5223129;
        Thu, 24 Feb 2022 17:26:11 -0800 (PST)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B39FDC1903;
        Fri, 25 Feb 2022 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645752371; bh=UVxlXhoomVeSptd34X6uqImNq9I6RDueQ2zWa3BTkZI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VIFJpotrF9EmNjo6BCndGOTYBlH1u9rmDnbeMj/L4wMIssWMPY3w/m322ch5d+T/c
         Pe+KSmvxpuJDNqWabnTt4hbXID2MKjhpOfs67zHMlQWX8dpYhM0paEkhvVAifmAEMo
         3e9LHC7ivr1IGNxJ3wzWqrx8mEhGgrAA9zk2QA9CXKbhcBl9XmJ2ZQShwbRaAwfXSY
         sLFekDXsHYAS6PLShnACDbwh/jtci24axqzyfeyrfGSiH3uFzO6z3DMHUbhABLXyMG
         VvShuJ7ScKsrhBs4xcFz7CzE6jVv8BnRHCyQTIenePNhgOL3kiYDfZ3rnk2HC9T4uk
         1T8mu6UF4buBg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 43AC4A0099;
        Fri, 25 Feb 2022 01:26:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E3FA140062;
        Fri, 25 Feb 2022 01:26:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="IFrqyh0M";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KysrOx1AV6qXN1AvoZSx+GSXSP1sG4Qe1SWWLlV+iAJvwEa8vC/UH0s0NouWYQzCboQunVy4tpuhCVPeZd8ebm4+VtR3ewEpQOee8S/UIDiejhwgaJFw7YzGjFMoncB13TaOWhomX2NPkFOLqCJCTBaKTPYXybFSX/bH3EbyPfBmDo2p4VNcrKlGYMnNZp26OMymNF8SAzAYRI2YAn2ZgdRVCDYfSmYcL7lbMzX3fCcJo4OJg06EnMRRirrB0anB7bE24J0yVh3ls6lbFfmi9Ol12aIJpCjAVnxrh6WJyr5Y0EaDSmL7Dqg8jlbWkkYgrPgkWrL0mYpk8BDazi/JiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVxlXhoomVeSptd34X6uqImNq9I6RDueQ2zWa3BTkZI=;
 b=TqKzHqSYXOsIbmxEem73OvAp763DFxTTBsCbpcMSNKF6db3LnEZpPjYd+ZjR3aRQjlxT0k4vtibOtgdbsfN4eA+6JXN0d05PRU0JHjdu0CMqi4OvmsIsDmVPdfMd9BX1AV07NeZUgfK2jPjiRKnJ/AsnyyTI2gxADaJQKcVnKKGs6WseEUooCGmZRAUjbHXkuw7OXRt+B8grpJYWtjj3M5CTrvH6BXWtRvXWXE5L/fyfJv2X42WXL3wvkJiUJDuumvao8yuANRCl204Tolc5prVhHS6aYw85mCpjopWkPSQsQEqM8CmUmAJ8o1PqicQ8z2rGiXDN5x21BFndTbgLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVxlXhoomVeSptd34X6uqImNq9I6RDueQ2zWa3BTkZI=;
 b=IFrqyh0MUWmNjmuGYAGcOZVBaln8vlwulIZn/inv0tac3/kE5rOUoxnBINDFWpFrLArdZbi0r41pNSDKfjEGGxlfn9oj9L8x0OJSRaNL0O8DLnELu28ypVwl9nf9jqHx+lAIc4XOQ46YoqzL7wc9/vpdncULShHxSp91TmBK6gQ=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 01:26:04 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::19df:84b5:e723:ac84]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::19df:84b5:e723:ac84%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 01:26:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuAgALM6QCAAD24AA==
Date:   Fri, 25 Feb 2022 01:26:02 +0000
Message-ID: <810de66c-7d73-fae0-9356-b06b48134ad6@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
 <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
 <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
In-Reply-To: <dbd00cb1-b5d0-24e7-ef72-dff3765c26cf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 554fda55-b0f6-4303-0db2-08d9f7fdca18
x-ms-traffictypediagnostic: MW3PR12MB4492:EE_
x-microsoft-antispam-prvs: <MW3PR12MB449269E00C7395EB9BEF1F27AA3E9@MW3PR12MB4492.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtLudR+yKiiyWBZmBaN7/wGldiuH0kKEOdooDxH0oHk2yNDwSk9boIxksMFEUkqBHA/GD4WqseqVlXi3K4JZAJ0wgQ7UQ4sdudHlwFsLSPWeZRqQ3UR4O1kKtHcVRBfEQDQ4vlPRGisQkQR1mUiSCJcyiSY3SkUiDjxwBTWo5d9hacTJAqmjC9rFlnRO1FNw/s8OFW6gN66KV9qUqybKn1pau/qKp4CUz+qpzC5IELfE2DjkBg4e+U6aaj9D/hCU1FT2Xk3XiEPLDrTousW+W2IO77+kQOfxDPwbFMIHa7zS6rD3ZrBmUXBIHA00lyep2rjVMVQzQp/bmJrc6YmIL+smzraImENrl5wI2kTAC0f4qmj0F+g3CjOQhCGhsEBrRmy5SC+PII19/Wct4TBt7sYTMq4z2XpuCTbZOFT6jiRNJG1AR5XnFp1mehBAuRdpe5MaCEbPMufw1/aMCrbUXOWHLhrnJ73o06+QqcILYoUg27DS/VcAd+0z+Dab7FWk7pAegesBXx+AvL+F68F8/3QwMopdbNU/12KiojITZgLXjHVKkkoud3D1DOQxhcDSKLI0lH+MFI9CylohY9Ry/vOg12z0T6jTiHpSTO5ry/SBWCZadMBkXYwChQeMhhsz0w5aBvGmCWnjHLAhGAySMIcRPUtSO68ESqpDzKm8vscPNV8Gz6BPjho9oSRcl38doA3WpXx485lAC7zWVHmUuzeE8Jb527tzuA2ulXkuXg9y5+NmCmF2eNZtXi2poR6lkrPtH3KbwBT3pN5g1EvnhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(122000001)(38100700002)(38070700005)(8936002)(86362001)(31696002)(5660300002)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(76116006)(6512007)(91956017)(508600001)(53546011)(6486002)(6506007)(2906002)(4326008)(83380400001)(110136005)(31686004)(36756003)(316002)(54906003)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDdDQWRqOE5HWFYwQUx5SmY0clpFYi9tczdYejBRYkdqN0kremI3OWhvK1dK?=
 =?utf-8?B?M2F1dWtWb2pjOVpRcTJrUDdxT3VRL0Y3RFU1RkNCQmxNL2Z6eUFsKzE5dzVB?=
 =?utf-8?B?SFdSZXE0SmptaUY5eXFvWGdHNmpXU1JZb1kxbVdMZGhRYldrZ3BqeG96SDdv?=
 =?utf-8?B?bmN1bDhIQzVZeDh6TEdLQ2t6bHdWVW9nT2dBbjJWa0RwRk03aUlyMkUxTVFF?=
 =?utf-8?B?NURKU2FyYUFjYVpDVG9uRHo3cW1ra2R2YVRDSWtWckxKQURXK0cvclVhVlg0?=
 =?utf-8?B?TUxiOVp4QVJvOExTZTdobnFIOFpnRlNxV0pJZXdlNW8wWXN5WjZza3Q3dXh0?=
 =?utf-8?B?dXRQM01jRldCRVFjRklmdDBIMEpjVUJaNDU0djBPM3VYSU1LMnNQTWVITzds?=
 =?utf-8?B?WGNjaHRpakFkOXlRb0I0SmpaaDlNeXpIRDh6Y2FIbkxIZzZwbWI3d1dSR1Zy?=
 =?utf-8?B?YUlTVTRzaWJhUVNqeDBwdXhiZkMyS0wyL3dBUWwyZkRlMGdOTi9kQW5iMkFh?=
 =?utf-8?B?OTJoVVdzNkRYbkJud3h0REF3ZHZiclUrb1hHK0VPM05sSEtDNi9ucHc3WmFH?=
 =?utf-8?B?aldvN3ZLamZtNkFNUmJaZHEvdEdWNitQY2pyci91WUJ3dmZUZHJ6NEVIbERa?=
 =?utf-8?B?UXh3OVRzUDZQb3V3Si8rcHpPNWJXN0Q2a2R0elJyZUt0NW1vNzVIUHg5L0hE?=
 =?utf-8?B?ZTNLOVJybVVPQnVQUFNyWGFzWkwydzBmSndKNGNDRjNwSms2UVNqcjZtWlhL?=
 =?utf-8?B?ZXpKUU5tVS9zd1MxcGdnVUtFRWRSZkZpNWhUVzRoSTgvWUJrcUdYMFZaeTJ1?=
 =?utf-8?B?bkpwVTYrSGJqY1RDWGJKVlU1ZGR1bFJiaWpJekxxcVFEMmRXdEljZUJscmw4?=
 =?utf-8?B?Z3VpQVY5eGJkaHVTcXpvYTZhK0VkNjJXYnJUK0NsakpUYWdwZUtLS25QZzUw?=
 =?utf-8?B?OWpqTXpvOXZJK3Q0L2ZEWDh4TE40YXNzeU83SkV1TXNzelZaeE5tL0N1d2ts?=
 =?utf-8?B?YzFKc1hRcURiL2t1YU95dk1SNERBNmdFV3RML2w3Zmk3TStXRTIyNmxPTGtE?=
 =?utf-8?B?REE2QkNHY2h3ckVRTHZxL1FITnVZT2FhbzVlSWgyTTFsajdzcnJJM1I0a3JP?=
 =?utf-8?B?TjllWWtyOG9YY0htV2hnNnFpc2xPRmh3TnRCNlo3b1p5eGJsaElLVU14eEVo?=
 =?utf-8?B?bHl5N3lxK3EramkwWjBkNU1jRTh1MnFMVCtiUS9CM0xMTElWcVAvUFRORC92?=
 =?utf-8?B?N0k3NDgzdG1oSHNSM25HTGt4WjRYdnJXRG5IVVFkV0JuZ2NGVHdWNSt2NUJh?=
 =?utf-8?B?SWFxcm55Mm1MZnF1Zmg0N2llWHhZbGdOdE5GOUNISXJQM0lCenRUQU5iUExW?=
 =?utf-8?B?MnZUeDFGcDNadUhldlQyUmZFK2pZT2E0d0FWRlV0UW9RUWxqTlpvUk8rQVBp?=
 =?utf-8?B?V1lSanFXK3VXc1pIY1dTNjRoT0MydEhTcVBWVGtvYTROWmlsQVpjZ0lPaGYy?=
 =?utf-8?B?bFBINnoxZ3plWWtzeDhSZy9TUldKN1V2dlRQTVFYOVN5cjJNL1Q4MW9FalNs?=
 =?utf-8?B?YTI4dHZMdGMyNk9kT1lZaXpiRW02eUFpaGFKek5zeXQ5dmxVa2x6b2pJT1BJ?=
 =?utf-8?B?cmhBSXdQOTMwT0owR3RIN3MyZXV5SkNYTEZPQThjdUdCZEJmQWNEUjliUVpv?=
 =?utf-8?B?UExGQVlaZDE2ODlldi9FUE1kaFhiMzExL3c4MERHZUs2OFg4YUkxY2Jjd3VU?=
 =?utf-8?B?U0VVZkFZTlAyZFZVYko5MUlRVTd2R3d6TDg3VDdPL1B5VjZzbVJGRVRmbW1I?=
 =?utf-8?B?L3JqbWNpUzFhQlpPbExSSTM1ZUlIalp6K005cHI3VmUxL2NDcU90RWNGUTlj?=
 =?utf-8?B?U0dxcS9UZ2pEYzBtZmlMVVRZeUJuV0paT1JUTlZ3UW9YeWIyUzJpcTI2U3J4?=
 =?utf-8?B?bW1RNU5aeE1pQVQwUC8vS0JtdzJLc0JGSlBBS1N3WnVhUk1TbmRtM0ZxTFMw?=
 =?utf-8?B?Rm5WNUxBdGlwOThsc1loZU4vRFpNbGkzL1FRTnZpTnRKUWxyOW1jWFVuZldN?=
 =?utf-8?B?cC9wa3c1eHZpVWNhWktrY0gzZmVoVUIreU5qandJbGRaUXMzVG1Vc0tzcDh5?=
 =?utf-8?B?U3grdXJLZnJMMk53Zm9mRElJV0Z4ZFNYd2h0aTUyOGtCaUtTUkROcFlaM3M4?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A1A9E513ACEC94B8824C2CBCB0652AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554fda55-b0f6-4303-0db2-08d9f7fdca18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 01:26:02.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLmgWQNgUKYPo1Ner2jK6RE8ZWOEjDLIhUWrwFTkpYtweD8DS9hd5A08ul+OKcgCHQZCcmAMMWj+vNj4sZsB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gT24g
Mi8yMi8yMDIyIDY6NTkgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEhpIFdlc2xleSwNCj4+
DQoNCjxzbmlwPg0KDQo+Pg0KPj4gQ2FuIHlvdSBwcm92aWRlIGEgZnVsbCB0cmFjZT8NCj4+DQo+
IFNvcnJ5IGZvciBkb2luZyB0aGlzLCBidXQgd2UgZGlkbid0IGhhdmUgYSB3YXkgdG8gc2hhcmUg
dGhlIGZpbGUNCj4gZGlyZWN0bHksIHNvIEkgaGF2ZSB0byBwYXN0ZSB0aGUgdHJhY2UgYmVsb3cu
IDovDQo+IA0KPj4gQnR3LCB3aGVuIHlvdSBleHBlcmltZW50IHdpdGggaW5jcmVhc2luZyB0aGUg
dGltZW91dCB0byAxMCBzZWNvbmRzLCBkaWQNCj4+IHlvdSB1c2UgdGhlIG1kZWxheSgpIGluIGVh
Y2ggbG9vcD8gVGhlIGRlbHRhIHRpbWUgZm9yIEVuZCBUcmFuc2Zlcg0KPj4gdGltZW91dCBoZXJl
IHNlZW1zIHZlcnkgc21hbGwuDQo+Pg0KPiBUaGlzIHBhcnRpY3VsYXIgcnVuIGRpZCBub3QgbW9k
aWZ5IHRoZSB0aW1lb3V0IGZvciB0aGUgY21kIHN0YXR1cyBwb2xsaW5nLg0KPiANCj4gSXMgdGhh
dCBzb21ldGhpbmcgdGhhdCB5b3Ugd2FudCB0byB0cnk/ICBOb3QgcGVydGFpbmluZyB0byB0aGlz
IGRlcXVldWUNCj4gc2l0dWF0aW9uLCBkdXJpbmcgdGhlIHB1bGx1cCBkaXNhYmxlIHBhdGggZGVi
dWcsIEkgbm90aWNlZCB0aGF0IGFzIGxvbmcNCj4gYXMgdGhlcmUgd2FzIGEgcGVuZGluZyBFUDAg
U0VUVVAgcGFja2V0IChub3QgZGF0YS9zdGF0dXMpIGNhY2hlZCBpbiB0aGUNCj4gY29udHJvbGxl
ciwgaXQgd291bGQgYWxzbyBoYXZlIGVuZHhmZXIgdGltZW91dHMgb24gbm9uLWNvbnRyb2wgRVBz
LiAgV2UNCj4gd2VyZSBhYmxlIHRvIGNhcHR1cmUgYSBidXMgc25pZmZlciBsb2cgKyBmdHJhY2Us
IGFuZCBpdCBzaG93ZWQgdGhhdCBhdA0KPiB0aGUgcG9pbnQgb2YgdGhlIGVycm9yLCB0aGUgbGVj
cm95L2J1cyBsb2cgc2F3IGEgU0VUVVAgdG9rZW4gQUNLJ2VkLA0KPiB3aGlsZSBvbiB0aGUgZnRy
YWNlLCB0aGVyZSB3ZXJlIGVuZHhmZXIgdGltZW91dHMgZm9yIGFsbCBub24tY29udHJvbCBFUHMN
Cj4gKGR1ZSB0byB0aGUgZHdjM19nYWRnZXRfc3RvcF9hY3RpdmVfdHJhbnNmZXJzKCkgY2FsbCkN
Cj4gDQo+IFRoYW5rcw0KPiBXZXNsZXkNCj4gDQo+IFRSQUNFDQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAN
Cg0KPHNuaXA+DQoNCj4gWyAxMDIzLjkxMjU1MDA1MCAgICAgICAweDRhZjY2NmZkMl0gICBkYmdf
dHJhY2VfbG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+IEZlYXR1cmUoSGFsdCBlcDRpbikNCj4g
WyAxMDIzLjkxMjkzNDczOCAgICAgICAweDRhZjY2OGNhYl0gICBkYmdfc2VuZF9lcF9jbWQ6IGVw
MG91dDogY21kICdTZXQNCj4gU3RhbGwnIFs0MDRdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVsDQo+IFsgMTAyMy45MTMzNjE1NjEgICAgICAg
MHg0YWY2NmFjYWVdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBvdXQ6IGNtZA0KPiAnU3RhcnQgVHJh
bnNmZXInIFs0MDZdIHBhcmFtcyAwMDAwMDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVz
Og0KPiBTdWNjZXNzZnVsDQo+IFsgMTAyNC4zMzY0ODA1NzMgICAgICAgMHg0YWZlMmEyOWJdICAg
ZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0KPiBGZWF0dXJlKEhhbHQgZXA1aW4p
DQo+IFsgMTAyNC4zMzY4NTU1NzMgICAgICAgMHg0YWZlMmJlYmNdICAgZGJnX3NlbmRfZXBfY21k
OiBlcDVpbjogY21kICdDbGVhcg0KPiBTdGFsbCcgWzQwNV0gcGFyYW1zIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gWyAxMDI0LjMzNzI2NDUzMSAg
ICAgICAweDRhZmUyZGQ2OF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMGluOiBjbWQgJ1N0YXJ0DQo+
IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0
YXR1czogU3VjY2Vzc2Z1bA0KPiBbIDEwMjQuMzUxOTEwMTU2ICAgICAgIDB4NGFmZTcyN2Q0XSAg
IGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQNCj4gJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2XSBw
YXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czoNCj4gU3VjY2Vzc2Z1
bA0KPiBbIDEwMjQuMzYzMTM5ODk2ICAgICAgIDB4NGFmZWE3MjBmXSAgIGRiZ190cmFjZV9sb2df
Y3RybDogQ2xlYXIgRW5kcG9pbnQNCj4gRmVhdHVyZShIYWx0IGVwNGluKQ0KPiBbIDEwMjQuMzYz
ODk4MjgxICAgICAgIDB4NGFmZWFhYWYwXSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQg
J1NldA0KPiBTdGFsbCcgWzQwNF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0t
PiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gWyAxMDI0LjM2NDczNDAxMCAgICAgICAweDRhZmVhZTk5
ZV0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kDQo+ICdTdGFydCBUcmFuc2ZlcicgWzQw
Nl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+IFN1Y2Nl
c3NmdWwNCj4gWyAxMDI0Ljc3NjE3MzgwMyAgICAgICAweDRiMDYzNzM5YV0gICBkYmdfdHJhY2Vf
bG9nX2N0cmw6IENsZWFyIEVuZHBvaW50DQo+IEZlYXR1cmUoSGFsdCBlcDVpbikNCj4gWyAxMDI0
Ljc3NjkwNzE4OCAgICAgICAweDRiMDYzYWE5Yl0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwNWluOiBj
bWQgJ0NsZWFyDQo+IFN0YWxsJyBbNDA1XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiBbIDEwMjQuNzc3NjQ2MTQ3ICAgICAgIDB4NGIw
NjNlMjA4XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwaW46IGNtZCAnU3RhcnQNCj4gVHJhbnNmZXIn
IFs0MDZdIHBhcmFtcyAwMDAwMDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNj
ZXNzZnVsDQo+IFsgMTAyNC43ODg2NDE5ODAgICAgICAgMHg0YjA2NzFhYjhdICAgZGJnX3NlbmRf
ZXBfY21kOiBlcDBvdXQ6IGNtZA0KPiAnU3RhcnQgVHJhbnNmZXInIFs0MDZdIHBhcmFtcyAwMDAw
MDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOg0KPiBTdWNjZXNzZnVsDQo+IFsgMTAy
NC43OTk2ODIzOTcgICAgICAgMHg0YjA2YTU2YmZdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVh
ciBFbmRwb2ludA0KPiBGZWF0dXJlKEhhbHQgZXA0aW4pDQo+IFsgMTAyNC44MDA0NDI2MDUgICAg
ICAgMHg0YjA2YThmYzNdICAgZGJnX3NlbmRfZXBfY21kOiBlcDBvdXQ6IGNtZCAnU2V0DQo+IFN0
YWxsJyBbNDA0XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czog
U3VjY2Vzc2Z1bA0KPiBbIDEwMjQuODAxMTg0NTg0ICAgICAgIDB4NGIwNmFjNzY5XSAgIGRiZ19z
ZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQNCj4gJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMg
MDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czoNCj4gU3VjY2Vzc2Z1bA0KPiBb
IDEwMjUuMjIyMTczNzUyICAgICAgIDB4NGIwZTYxZDk5XSAgIGRiZ190cmFjZV9sb2dfY3RybDog
Q2xlYXIgRW5kcG9pbnQNCj4gRmVhdHVyZShIYWx0IGVwNWluKQ0KPiBbIDEwMjUuMjIyOTkxNjY5
ICAgICAgIDB4NGIwZTY1YWYxXSAgIGRiZ19zZW5kX2VwX2NtZDogZXA1aW46IGNtZCAnQ2xlYXIN
Cj4gU3RhbGwnIFs0MDVdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3Rh
dHVzOiBTdWNjZXNzZnVsDQo+IFsgMTAyNS4yMjM4NTA3MzEgICAgICAgMHg0YjBlNjliNWZdICAg
ZGJnX3NlbmRfZXBfY21kOiBlcDBpbjogY21kICdTdGFydA0KPiBUcmFuc2ZlcicgWzQwNl0gcGFy
YW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4g
WyAxMDI1LjIzOTAyMzQ5MiAgICAgICAweDRiMGViMGQ1NF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVw
MG91dDogY21kDQo+ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZh
MDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+IFN1Y2Nlc3NmdWwNCj4gWyAxMDI1LjI0ODk2MzE3
OSAgICAgICAweDRiMGVkZjZjZV0gICBkYmdfdHJhY2VfbG9nX2N0cmw6IENsZWFyIEVuZHBvaW50
DQo+IEZlYXR1cmUoSGFsdCBlcDRpbikNCj4gWyAxMDI1LjI0OTcwOTg0NiAgICAgICAweDRiMGVl
MmVjZF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kICdTZXQNCj4gU3RhbGwnIFs0MDRd
IHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBTdWNjZXNzZnVs
DQo+IFsgMTAyNS4yNTA1MzM0NDAgICAgICAgMHg0YjBlZTZjOTNdICAgZGJnX3NlbmRfZXBfY21k
OiBlcDBvdXQ6IGNtZA0KPiAnU3RhcnQgVHJhbnNmZXInIFs0MDZdIHBhcmFtcyAwMDAwMDAwMCBl
ZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOg0KPiBTdWNjZXNzZnVsDQo+IFsgMTAyNS42Njcw
ODQ1MzUgICAgICAgMHg0YjE2ODc1ZTddICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRw
b2ludA0KPiBGZWF0dXJlKEhhbHQgZXA1aW4pDQo+IFsgMTAyNS42Njc4Mjc3NjQgICAgICAgMHg0
YjE2OGFkYTZdICAgZGJnX3NlbmRfZXBfY21kOiBlcDVpbjogY21kICdDbGVhcg0KPiBTdGFsbCcg
WzQwNV0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nl
c3NmdWwNCj4gWyAxMDI1LjY2ODYzNTk5MyAgICAgICAweDRiMTY4ZWE0NF0gICBkYmdfc2VuZF9l
cF9jbWQ6IGVwMGluOiBjbWQgJ1N0YXJ0DQo+IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAw
MDAgZWZmZmEwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiBbIDEwMjUuNjc0
Nzc3NzY0ICAgICAgIDB4NGIxNmFiNmU3XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQN
Cj4gJ1N0YXJ0IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAwMDAw
MDAgLS0+IHN0YXR1czoNCj4gU3VjY2Vzc2Z1bA0KPiBbIDEwMjUuNjg0NzMzNTk3ICAgICAgIDB4
NGIxNmRhMTk3XSAgIGRiZ190cmFjZV9sb2dfY3RybDogQ2xlYXIgRW5kcG9pbnQNCj4gRmVhdHVy
ZShIYWx0IGVwNGluKQ0KPiBbIDEwMjUuNjg1MzM2MTUwICAgICAgIDB4NGIxNmRjZWM3XSAgIGRi
Z19zZW5kX2VwX2NtZDogZXAwb3V0OiBjbWQgJ1NldA0KPiBTdGFsbCcgWzQwNF0gcGFyYW1zIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gWyAxMDI1
LjY4NjExMjYwOCAgICAgICAweDRiMTZlMDkwNF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDog
Y21kDQo+ICdTdGFydCBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVmZmZhMDAwIDAw
MDAwMDAwIC0tPiBzdGF0dXM6DQo+IFN1Y2Nlc3NmdWwNCj4gWyAxMDI1LjY5ODg0MjM0NyAgICAg
ICAweDRiMTcxYzNiZl0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMG91dDogY21kICdTZXQNCj4gU3Rh
bGwnIFs0MDRdIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBT
dWNjZXNzZnVsDQo+IFsgMTAyNi40NDQwNTE1NjkgICAgICAgMHg0YjI0YzE2NzBdICAgZGJnX3Nl
bmRfZXBfY21kOiBlcDBvdXQ6IGNtZA0KPiAnU3RhcnQgVHJhbnNmZXInIFs0MDZdIHBhcmFtcyAw
MDAwMDAwMCBlZmZmYTAwMCAwMDAwMDAwMCAtLT4gc3RhdHVzOiBObw0KPiBSZXNvdXJjZQ0KDQpX
aHkgZGlkIHRoaXMgZmFpbCB3aXRoIE5vIFJlc291cmNlPyBXYXMgaXQgc2VudCBiZWZvcmUgdGhl
IGNvbnRyb2wgVFJCDQpjb21wbGV0aW9uPw0KDQo+IFsgMTAyNy4yMjU3MDU0MjUgICAgICAgMHg0
YjMzMTE2NzhdICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0KPiBGZWF0dXJl
KEhhbHQgZXA1aW4pDQo+IFsgMTAyNy4yMjU4MjAxNjUgICAgICAgMHg0YjMzMTFmMTRdICAgZGJn
X3NlbmRfZXBfY21kOiBlcDVpbjogY21kICdDbGVhcg0KPiBTdGFsbCcgWzQwNV0gcGFyYW1zIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gWyAxMDI3
LjIyNTkzMTQ2NyAgICAgICAweDRiMzMxMjc2Y10gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMGluOiBj
bWQgJ1N0YXJ0DQo+IFRyYW5zZmVyJyBbNDA2XSBwYXJhbXMgMDAwMDAwMDAgZWZmZmEwMDAgMDAw
MDAwMDAgLS0+IHN0YXR1czogU3VjY2Vzc2Z1bA0KPiBbIDEwMjcuMjM0MzExNDY3ICAgICAgIDB4
NGIzMzM5YmVkXSAgIGRiZ19lcF9kZXF1ZXVlOiBlcDdpbjogcmVxDQo+IGZmZmZmZjg3Zjk5Yjhm
MDAgbGVuZ3RoIDAvNjE2OTYgenNJID09PiAtMTE1DQo+IFsgMTAyNy4yNDc0MDkxMjMgICAgICAg
MHg0YjMzNzcyM2ZdICAgZGJnX3NlbmRfZXBfY21kOiBlcDdpbjogY21kICdFbmQNCj4gVHJhbnNm
ZXInIFtmMGQwOF0gcGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6
IFRpbWVkIE91dA0KPiANCg0KSWYgdGhlIFN0YXJ0IFRyYW5zZmVyIGZvciBlcDAgZmFpbGVkIGFu
ZCB0aGUgU2V0dXAgcGFja2V0IGNhbid0IGJlDQpETUEnZWQgb3V0LCB0aGUgRW5kIFRyYW5zZmVy
IG1heSBub3QgZ28gdGhyb3VnaC4NCg0KQ2FuIHlvdSBsZWF2ZSB0aGUgbG9nIHVuZmlsdGVyZWQg
YW5kIGlzIGl0IHBvc3NpYmxlIHRvIHNlbmQgYXMNCmF0dGFjaG1lbnQ/IEl0J3MgbWlzc2luZyBz
b21lIGltcG9ydGFudCBpbmZvIGluIHRoaXMgbG9nLg0KDQpUaGFua3MsDQpUaGluaA0K
