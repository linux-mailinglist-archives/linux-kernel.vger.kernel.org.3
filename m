Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E84D5E29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiCKJQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbiCKJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:16:11 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F521BB73F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646990106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9CS46NAEkBLt64mtyyZbvH8XbrCfc4HmofCzdgTn74=;
        b=Pa8HdlKhG/DhwsSgx0cp/RXj02dnjnIV8KKUvjH0F3zhA05fwTqLmsI8NCfBln0ftj85ZL
        rzANNXzNY/ruE7vnafzkgwlDMCrk7T7ycoK9zXS756LJjk40YDSMb/+7SiI6Aomgdlf+S1
        KpNvpsxqaSstR7SQG0esM0YXdh4Zrdw=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-9HesBFAPMT6G-MR35RlmKQ-1; Fri, 11 Mar 2022 10:15:04 +0100
X-MC-Unique: 9HesBFAPMT6G-MR35RlmKQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QndbvEtY3Drq4zpb1m+JFJmGfrEut/lYMm5EDr8W/FoJrGeVHMJKCG4+tcl1sjiAJWlwc1p0LXb0qrm9/ylzaNWtbAPf+MvOcbggfpzLAtmLC6hoVWYDHEw0zr9A1OkqvOTT7EpdAHK/6adBxsr4Z6/9n+PvXN9IlWVP7rDDRLUN3Nvk3wiufiuCUDK8nh2N7KHTCehiudceGVUSsz7qB+eH/nZVpKBC8T/VcYCwzrB3uMaWuNknr+6hZMt8pjOWTIiHOuaQSXjPmlVYW5NNb3F1wWQNe0MMZi4YEetRxgZr86nS04uQQilpy2QRz0+V2slfWmnaOG1W1YTa/gHkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9CS46NAEkBLt64mtyyZbvH8XbrCfc4HmofCzdgTn74=;
 b=aJ6DlLUTZudtf5kcQibPH/KALxgx/ZQoh6sc/C/mO0702HyFG+alhUjFHzwvyKaiMDbxSGJ9emCF2UGQLwEKeNOVhStoT8jcRPqBMM0dT4snG0nCdMrrFK6OdyNaZ8nSqu50L34zbq1aEvAhwbdA0TZU5orFU3/pQ03g/EoGDpItdvEhic+6sQyZn4xs6qD+S14G+ZMNgRiABg6BaHLYoZPlNpIMDdMmNoIF6YtHpvtB4h8PJHjNCD3q42qMT2ApJVy+VOQtqxgDvMs9icXyvEMlZrCMFo5RlNRgSgTe7QAANmK3bgaSGHY7DjDyusYU/ZNoVx2+WeuuxMYmgNTRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM9PR04MB8714.eurprd04.prod.outlook.com
 (2603:10a6:20b:43d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 09:15:03 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::8c99:1891:1f52:901d]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::8c99:1891:1f52:901d%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 09:15:03 +0000
Subject: Re: [PATCH] target/iscsi: Fix detection of excess number of login
 exchanges
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <ppavlu@suse.cz>,
        martin.petersen@oracle.com
References: <20220222124217.21715-1-ppavlu@suse.cz>
 <a7e1f13e-326f-fdba-5272-9cbc7ba2a3cf@oracle.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
Message-ID: <7650feb7-264c-b142-d8f0-23576ffe7d29@suse.com>
Date:   Fri, 11 Mar 2022 10:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a7e1f13e-326f-fdba-5272-9cbc7ba2a3cf@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------D2C1E3D891DD5BDC0E19FBDD"
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0093.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::34) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a1232f-414d-44be-87a8-08da033fa020
X-MS-TrafficTypeDiagnostic: AM9PR04MB8714:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB871455455CAFB592FB2691BDE60C9@AM9PR04MB8714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYPuGTF2JquCPVWLCBNBP33El1e82RqIG2JSsFznXZeWhrpUJTrKYgKuxJcp9zwhxc7G8zHo8BK51lL7+oumbBBuQFpaI2hdLqNwjHCYJJ/yvNNPosZFLaB/Na+AZ3Zz5uyd8JMwb/xl450G6ml35gnta5JUL2gCM5itMtnt9zcixQh2e7cVJdSPNx1dPQb9rpWppHpVUOyIaL2fyOtgGWay1Dl4dMSaUWCPJNpy1Cf/crnLdZSzBEx43+qJliELfGUCubjd0ZjJoQfFOnu4IoDW0qrmK5EYGVYtXQwUOwI/GNrv8CmqQnkAeBOlxFgbmF1H7fhLL9AWkHmH93xkPmoj2R1xRf0YEzSjOInudpI49XCc62N/SnMItcGyxM3nloykFSmaIljXqCsmCohNl5qB5b+1x6XYLFPWtgoCZOxOdD4xy60efR301T1RWyMRoHmfV+e0KlC7Wukgz6/CKYigKWUx4fMAXQcXXnW5zAEqyI/5j0bJhoB/oIqCBhHvgMRyVmuSW4pR7BoliRMIeNmYSyJAAEyos7mHLWLzUGS9OuGOqKJmhoE630Sy7TgpzWt+AljCcgyIyh6U1r8oAztt6T7WqvbzPQwZwmq6LgCeMxzFj4RHH96t5T9HZ38+I9nSleH4bpZQL8oR+QOevzmSQAcnPN/rvfoQRxuM345IpLZQSgUAgw8DMlYZnEn2PD2g/P++/PDLleZ9qSRXteegHKjVyLNy4i/7BT0q8To=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66476007)(66556008)(2906002)(31696002)(8676002)(2616005)(83380400001)(66946007)(4326008)(6512007)(6486002)(6916009)(44832011)(26005)(186003)(8936002)(53546011)(33964004)(31686004)(235185007)(86362001)(6506007)(5660300002)(36756003)(508600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpOaDJkWFJtelFGY2JkU1BlWlhyTUxRVUxwa0VHWTNKSm5WamZnSS9tWE1x?=
 =?utf-8?B?a0p0YS83NzdjN1grVGxYelNCaHBobFFERDZGWFVsN1dmV3BWU1R3VXdCMWVW?=
 =?utf-8?B?eFZ3TWtjd2oyUiswTDR5WFlaWTVyYjBxdW1CWDgxMmFGUHhIdkdvVHIxQmVF?=
 =?utf-8?B?VDlHTHZHaFJRUG5Ec0tnNlZ4aXB5aXZCeEVPT2d5ek03dGRlQTF3am5PSjRp?=
 =?utf-8?B?Vjlob241Zk1WMG94SFRoRWZEVitoUGJpajU2SHVMdnB2TDVLR3MrZXJQWGVO?=
 =?utf-8?B?dmpoUlNtVks0NlV6cHdKN1A3N01mY1EraWdoWGRQcG1sVUMxMjc1dUpWT3Nx?=
 =?utf-8?B?TUNkVlB4VjVFZFpGb0hlWFc3M2llbTEwQnhhV2tjV1F0cTgvSWxrV2ZoZURk?=
 =?utf-8?B?M0NvY3lZL0lXZDZTZ3haSjh1ZFVxNUVNRXczV29IejEySmFadnFhZ3RGcXIz?=
 =?utf-8?B?czhLSVA0VlNtUHV3TTliM3B4TUprMENJZEZTUE53OXBLTHdVSWFCeTVFU2Jz?=
 =?utf-8?B?U3lRQklUZzlwLytQTHNzV0xwY1RvZVZkbldYMXdZOUVTTnprTGlCZGZtRDBt?=
 =?utf-8?B?bXJTOXZWS1hWc0hpVDIrWmpKMUFtbG5uTDBOdVVlbUNPNG5PS28zTjNmNWpm?=
 =?utf-8?B?U0pYZWo1Y0c4VDlScTZGMEllNThIUlkyOXlSTFVULzN0QmN0d2dxRE8rZmtD?=
 =?utf-8?B?WjFEdFAxWmFXZTVoRG9UZWUrQlRQajY1OWtUZ2wrTmFxd0cxTS9mUWt1cXQ3?=
 =?utf-8?B?N3h0VjgySkR2MjVaclJNZ05aWWNxTW1NSWV3cHUvWkEvMXBIekhjTzJQa1Zw?=
 =?utf-8?B?V25JdTJyMEdHT1I2YkJsWjFHMk1CT2RzbFRkWnRTNXFPZ1huZnVtTi90L2lN?=
 =?utf-8?B?VU9EeDVwa0FRTG9sOWQ0OHVVNWJNWnRnek55K2k5SHBYRUtLWEJ3bWVFTndV?=
 =?utf-8?B?aE04cXA2K1ljQ2JsNEgrT1FDY2lybkJOQS9nakVVUGE3ZWpnOUs2SnlKZUg1?=
 =?utf-8?B?TU9OcC8rR1IzNGVpa0gvYWdTd0Y2M0hOZDVaY3lPN0ZZQnBjWFV3S2o5eW5o?=
 =?utf-8?B?eXJWWFpYUTIzd1p1WmhCcVlseDFYK2pTTlVHNmxkM1RXSFF6MmxnOUkxUVM3?=
 =?utf-8?B?Wm9UUXV3OXRpNE1hL0ZjR3BWVmpyTDJuQmVsZEdsQkN5TWdzbGJTdlJuRm9N?=
 =?utf-8?B?M3Q3K0M4RkNmRkMxMXR0WFFST2NtMGRXUm9Qa0JJK01kcmpVUGJPelFCY2tZ?=
 =?utf-8?B?d2hoOEFlZ0RjVVRhZWE3NEhsQWFDTDhPbmdvR2ZjcjBGQVN0d3ZNWjFlL3hh?=
 =?utf-8?B?RFlzVlllZTF5R0RpUUxQR1hvNTFJN012MHJzOWZld3RCVVJHTGNKWEJhck9k?=
 =?utf-8?B?L3VEaytLKzZGSDB3cDR6UjRhZGJrVnpsdDZLWEI1dXR0Qy83UjZ2bzVNRVM2?=
 =?utf-8?B?ekprVzd5QWl6eUdHNG9rTWtmWEVmQVpVUjlYMmI2a2h4THJTZHg5OFRWbktU?=
 =?utf-8?B?Z1NmRzFzQnR4MlJzeE1ibTIrRmMzZEpiemQ3T0M4Q0pHN2xWVWJhTXZTUWtq?=
 =?utf-8?B?M0lHKzdSenU5TklJandBbStnK2hSVE0ya3Q1ckF4Qi9sMFlXYXNibXRhODZn?=
 =?utf-8?B?NzhaeGF1UzZJTTIydWtLSm9kaS82bDRjK1JVbXVobDBlWUs3bVV4M1hKcFFh?=
 =?utf-8?B?Z3lxYnd3anVLUFYyMyt1YVdGUStHYkVGZ1NFNW80WHI3dDVyNTc2a3hIeXVU?=
 =?utf-8?B?T2taVWc5bEUxbzNneGdndkdYRGN1MWN3TW1zeUVKZ3ZLdzkxMnlaNWtHY1pW?=
 =?utf-8?B?TTQ4bWlFcnMrbElXN2FabHp5WDZIemxhVHIzd2lWUWQzcUt1Tm9oc1ErT3pp?=
 =?utf-8?B?S0Q2SG9WNTFPS3llTEJQMUZEKzVRZUU1VzJUd1FEVzNNMVE0N3RTTHNtZVpI?=
 =?utf-8?Q?Qyc3i/c3upjuer3WzoVEGLD/7k7+qX0j?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a1232f-414d-44be-87a8-08da033fa020
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:15:03.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XTZyW/3b0vCJmFfmBhq5aMUEU9AMOFzb/aoY3MgF5nKmUee3/brJSumL2oWsg1hAd7qThnWSR+o9CAF7dCQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8714
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------D2C1E3D891DD5BDC0E19FBDD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/1/22 2:23 AM, Mike Christie wrote:
> On 2/22/22 6:42 AM, Petr Pavlu wrote:
>> From: Petr Pavlu <petr.pavlu@suse.com>
>>
>> Function iscsi_target_do_login() attempts to cancel a connection when
>> a number of login exchanges reaches MAX_LOGIN_PDUS (7). This is done by
>> having a local counter and incrementing+checking it as the function
>> processes requests in a loop. A problem is that since the login rework in
>> back in 2013, the function always processes only a single request and the
>> loop is terminated at the end of the first iteration. This means the
>> counter reaches only value 1 and any excess number of login requests is
>> never rejected.
>>
>> Fix the problem by introducing iscsi_login.negotiation_exchanges counter
>> and update the logic to count exchanges per each login phase as described
>> in RFC 7143:
>>> 6.2. Text Mode Negotiation:
>>> [...]
>>> In the Login Phase (see Section 6.3), every stage is a separate
>>> negotiation. [...]
>>> [...]
>>> An iSCSI initiator or target MAY terminate a negotiation that does
>>> not terminate within an implementation-specific reasonable time or
>>> number of exchanges but SHOULD allow at least six (6) exchanges.
>>
> 
> It wasn't clear to me what this fixes. Today, are initiators sending more
> than 6 exchanges and if so what happens to the target? Is it crashing or
> annoying to user or cause some sort of endless login so we run out of
> resources? Or is this more of code cleanup?
> 
> When does this happen and with what initiators?

This issue is only something that I noticed while reading through the target
code because of some different problem. In that sense, the patch is more
a code cleanup. My tests to verify the patch were also artificial (attached).

I have now additionally tried some simple examples with sending extensive
number of Login requests in a loop to the target and did not observe any
immediate problem with running out of resources. A possible alternative might
be therefore to remove this logic, not sure.

Thanks,
Petr

--------------D2C1E3D891DD5BDC0E19FBDD
Content-Type: text/x-python; charset=UTF-8;
 name="target-test.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="target-test.py"

#!/usr/bin/python3

import socket

# Test excess number of exchanges during security negotiation.
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(('192.168.122.30', 3260))
    send = (
        b'\x43'                      # 00: -> Immediate marker + Login request
        b'\x00'                      # 01: -> Continue security negotiation
        b'\x00'                      # 02: VersionMax
        b'\x00'                      # 03: VersionMin
        b'\x00'                      # 04: TotalAHSLength
        b'\x00\x00\x8c'              # 05: DataSegmentLength
        b'\x0c\xfd\x37\x00\x00\x01'  # 08: ISID -> OUI, SUSE, Qualifier=1
        b'\x00\x00'                  # 14: TSIH
        b'\x00\x00\x00\x00'          # 16: InitiatorTaskTag
        b'\x00\x00'                  # 20: CID
        b'\x00\x00'                  # 22: Reserved
        b'\x00\x00\x00\x00'          # 24: CmdSN
        b'\x00\x00\x00\x00'          # 28: ExpStatSN
        b'\x00\x00\x00\x00'          # 32: Reserved
        b'\x00\x00\x00\x00'          # 36: Reserved
        b'\x00\x00\x00\x00'          # 40: Reserved
        b'\x00\x00\x00\x00'          # 44: Reserved
        # 48: Login parameters
        b'InitiatorName=iqn.1996-04.de.suse:01:6fd07434abf9\x00'
        b'SessionType=Normal\x00'
        b'TargetName=iqn.2003-01.org.linux-iscsi.localhost.x8664:sn.8726b6baa6b9\x00'
        # 188: Padding to 4 bytes
        b''
        # 188:
    )
    for i in range(1, 8):
        print(f"Send #{i}: {send}")
        s.sendall(send)
        data = s.recv(1024)
        print(f"Response: {data}")
        assert data[0] == 0x23  # Opcode
        assert data[36] == (0 if i < 7 else 3)  # Status-Class
        assert data[37] == 0  # Status-Detail

print()

# Test excess number of exchanges during operation parameter negotiation.
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(('192.168.122.30', 3260))
    send = (
        b'\x43'                      # 00: -> Immediate marker + Login request
        b'\x81'                      # 01: -> Transfer to operational parameter negotiation
        b'\x00'                      # 02: VersionMax
        b'\x00'                      # 03: VersionMin
        b'\x00'                      # 04: TotalAHSLength
        b'\x00\x00\x9c'              # 05: DataSegmentLength
        b'\x0c\xfd\x37\x00\x00\x01'  # 08: ISID -> OUI, SUSE, Qualifier=1
        b'\x00\x00'                  # 14: TSIH
        b'\x00\x00\x00\x00'          # 16: InitiatorTaskTag
        b'\x00\x00'                  # 20: CID
        b'\x00\x00'                  # 22: Reserved
        b'\x00\x00\x00\x00'          # 24: CmdSN
        b'\x00\x00\x00\x00'          # 28: ExpStatSN
        b'\x00\x00\x00\x00'          # 32: Reserved
        b'\x00\x00\x00\x00'          # 36: Reserved
        b'\x00\x00\x00\x00'          # 40: Reserved
        b'\x00\x00\x00\x00'          # 44: Reserved
        # 48: Login parameters
        b'InitiatorName=iqn.1996-04.de.suse:01:6fd07434abf9\x00'
        b'SessionType=Normal\x00'
        b'TargetName=iqn.2003-01.org.linux-iscsi.localhost.x8664:sn.8726b6baa6b9\x00'
        b'AuthMethod=None\x00'
        # 204: Padding to 4 bytes
        b''
        # 204:
    )
    print(f"Send #1: {send}")
    s.sendall(send)
    data = s.recv(1024)
    print(f"Response: {data}")
    assert data[0] == 0x23  # Opcode
    assert data[1] == 0x81  # -> Transfer to operational parameter negotiation
    assert data[36] == 0  # Status-Class
    assert data[37] == 0  # Status-Detail

    send = (
        b'\x43'                      # 00: -> Immediate marker + Login request
        b'\x04'                      # 01: -> Continue operational parameter negotiation
        b'\x00'                      # 02: VersionMax
        b'\x00'                      # 03: VersionMin
        b'\x00'                      # 04: TotalAHSLength
        b'\x00\x00\x12'              # 05: DataSegmentLength
        b'\x0c\xfd\x37\x00\x00\x01'  # 08: ISID -> OUI, SUSE, Qualifier=1
        b'\x00\x00'                  # 14: TSIH
        b'\x00\x00\x00\x00'          # 16: InitiatorTaskTag
        b'\x00\x00'                  # 20: CID
        b'\x00\x00'                  # 22: Reserved
        b'\x00\x00\x00\x00'          # 24: CmdSN
        b'\x00\x00\x00\x00'          # 28: ExpStatSN
        b'\x00\x00\x00\x00'          # 32: Reserved
        b'\x00\x00\x00\x00'          # 36: Reserved
        b'\x00\x00\x00\x00'          # 40: Reserved
        b'\x00\x00\x00\x00'          # 44: Reserved
        # 48: Login parameters
        b'HeaderDigest=None\x00'
        # 66: Padding to 4 bytes
        b'\x00\x00'
        # 68:
    )
    for i in range(2, 9):
        print(f"Send #{i}: {send}")
        s.sendall(send)
        data = s.recv(1024)
        print(f"Response: {data}")
        assert data[0] == 0x23
        assert data[36] == (0 if i < 8 else 3)  # Status-Class
        assert data[37] == 0  # Status-Detail

--------------D2C1E3D891DD5BDC0E19FBDD--

