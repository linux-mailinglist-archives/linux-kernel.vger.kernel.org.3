Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F244DD6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiCRJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiCRJHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:07:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2130.outbound.protection.outlook.com [40.107.212.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693591877D7;
        Fri, 18 Mar 2022 02:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq5WQ7f6VgrJRLv/Ews8wyPjP7OURJqom+SfFgsYCZ8zyd2kP4TldUx1OWHC6iHcFRRkESXFlsJgI+u1QUE0F5VMIrZh05+DwX5ExwbLAZCSKwqMHsy3dF+/nqNTDr5usv107Oe+1yFCVD5UNDbW2JtoHAlbFwKaPmMiw3TVCWCay4p0DxjA+vbfr0XkrMM9XbXl67eue4gD9Sl3ZxJ1Osyz8aXIoZ85evZlQetCSwmYJajQZrPr0XhHvLOSfGCqSwluVAl1fa/IXGiTAvmZQxid2X37YTYziSOZg5SJnf+89dq0Yb8vCSJAja/s0hKZY/07EDIm8gnqopg06BOrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKOSOcatYmpNU9nFsqGWpUjmJ6AmfqBwIYhf5rBTYpE=;
 b=Xmz1ID0gnYJ6bGF0dHiIMKLMDjp16cd+ZHz5gqd6Tkp+IVA46RViIASN0t0JWp9mAaXlunPmFWgxESO4CaT0tCdnTu82CO6OAM7VMuTKO3+4eLgFyQ/j5PYQu4xVwgfzTnSOHDD3gOoR09t+Jrmm/S0GHIsZ2DQRqNvMh9qAbvZgPoE6x32m7BUTEaKQOuHTXHJ62I5ofa3idDecQBsawtfE5WhLe+F6bw8yhYljFa6YWqpcMGb671YNtGT3XRNwEiIshPBajm8det88aryAOt3wxRRhSIO7NdwA4AYr1gy5LJkFwbH7wa4QjsN4M0OzOyHt7xW8IhtJH22HIJFVyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKOSOcatYmpNU9nFsqGWpUjmJ6AmfqBwIYhf5rBTYpE=;
 b=CoblLBnmUWAqu2f+CbkyZNUT76WqGZfF0DByculvS7VZDMYZy1IkKkuR4C89Ojd6yFW3eigCroE8TkuipF8AZnOxa7BzpvWsjNdfZ18yoimOTgViVN/2Dw7sNigqJaMpHOEm8XpClswnIXs4qhj+ZLwJQoAnXGv8HW0tqbBEaAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 09:06:32 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::919c:b806:f259:e276%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 09:06:32 +0000
Message-ID: <4198920d-298c-6565-5d97-9d0a8fcc8441@fortanix.com>
Date:   Fri, 18 Mar 2022 10:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in
 microcode update
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-10-cathy.zhang@intel.com>
 <53e7d3a3-a576-7ef1-fa2d-d170fa1172a1@fortanix.com>
 <e1682971-4821-8e57-3232-de7a72086991@fortanix.com>
 <e121e972-7689-b2f3-5919-746e3a90cb36@intel.com>
From:   Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <e121e972-7689-b2f3-5919-746e3a90cb36@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020204040904070104010800"
X-ClientProxiedBy: AM4PR0701CA0005.eurprd07.prod.outlook.com
 (2603:10a6:200:42::15) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad8bf6a-5581-4c10-c134-08da08be9849
X-MS-TrafficTypeDiagnostic: CH0PR11MB5426:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5426F9912CA2763C4A0A9933AA139@CH0PR11MB5426.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mly6R2c203j1y3SywrNxlwiM2+eQKo2tNTiFDtuEsbH8CaD8fdoalEeahiQS09FNmYbSPTjemPG7+KQspXtppLgUFIayvQz146oMXpqr9R4O7M2qYJWhhawZFk6UApQRjYgN3SxDDWPW6tAltYKjPE4pbtYr6S4iE6CE/XRCP6otitCfSAbRlvX6yMKbXRRByVszeT9gPU9GLo+yXyRSGatSU7LfExffiP774vHh3b0r2nifY+KnP4zBzUsMcPPPh7tfUDwS57XvbPiiPw6Hgup+RQOfKOGM6GQf+bOQkQ3tzcG6P54zrSiKKzedgHChw9b+cz1m861ogpCTR0ZlKhmA55M/NceOnePk/u9oow1pti/hkucVEXPDPwHNGcaG/0fNFMrZZGgDVntiL34lgpWldT9CRk+jq7HMArwVcxt+J7i67nTv2sUncJwANDdPt9nE2JQ5bme57qljLhpbPZYksPQJoZuUuvVvZa2plENi+WNI1GTYJR8PICDw+0klUKygU5XjZH/RNgBIGcLR2JCFLDiv7xxyWUjZZWQdPfINhmU6/SfFXQJ5ul8LZjVSL5c+yPoC/+jid2QN2EV1LfPMKiybZ9+zjhj4wt2ucuk8Y4Dk9/tApA3HpuM/swY9BHNplR8XtxigniIR9IC1PSA3LwHi8R0JQqhV9Zu73eMhDuQswbGPrYmGhPC68liWOLcodGOGTgKn7Gu+eUE+5FhYZ6R8qOli60e1Z1rDcDAbcwhptPnY73+1IT95icPc/bdm4jnNSP/bYATCqUDDSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(15650500001)(186003)(26005)(6506007)(33964004)(52116002)(53546011)(2616005)(6512007)(2906002)(83380400001)(66476007)(66556008)(66946007)(8676002)(31696002)(86362001)(110136005)(4326008)(8936002)(36756003)(316002)(31686004)(5660300002)(235185007)(508600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JNWXhPNkdKSDZsN0N5ZVU4VHdzZk9EWUxzaTh4SGZHNjVkdzlpbUxEcXVL?=
 =?utf-8?B?K3RTRnpQc3lwQ0d6QzR2SlRqdzBLOGR3NWlvUzZDV1RhZlJrME9QNk90RC93?=
 =?utf-8?B?VW9hSXVWbUpIV2wvRlM3cjdWd1VWeVlmNWdoVEVVK3dFa0Vyb2kzeTBsMEFT?=
 =?utf-8?B?Rndycnd3R1oyVlYvTFl5NDF4YWpHWG5zR0dVdkgwT2VEamh5NzFqd1JsQXFD?=
 =?utf-8?B?MDRubjVNb2xTRTJPaStTNzlFQ3cwa1MwVllwYU5IVkNucm5ZdGFQWE1hMW80?=
 =?utf-8?B?cGRvRkFvRFkyNElXNUVIUk53RUtGeUhwSlhvdjR2Ly9tOFhqM2pHZnhQNWho?=
 =?utf-8?B?WFluSWV4RTczSGFRZzlSa1lXcnpsNjhaY25rR3ZRWDczTURQT2RtQWdWK0V0?=
 =?utf-8?B?aVlnS0lxdUpzUlRyNkpjb1FEWFNqRUxmQk5XcW9hWUw2MGFKOC9vWTYyVERs?=
 =?utf-8?B?bGJNQU9HRTBrK05xQ1BWRHVvZ1ZhelRTWDdKdWhzWE5NSDZsYVp2OWdwWXMz?=
 =?utf-8?B?bE5MbjVGYzhlalUrR2dPSVY5bEhmSk1yYkNnOUU5cFE5MjRSSVQ4a0NTeVBu?=
 =?utf-8?B?M0UraVJuandKZE8waU5sdFRpakk2a244UVhtT2orUDZjSnNLQVNxNHIvdW9o?=
 =?utf-8?B?cTRkemlGRmUvM0xIUmo0dmplUXhNN1dITzB3ems4Y3ZsWG13aWR4ckZacEtR?=
 =?utf-8?B?YXRnSk1RS2dpNVFtRThPdkxJdTNJOUNKQkQ4RWs4c2RwdXNwQjF4clcrck5t?=
 =?utf-8?B?OE1wWXRPd3kzeDg2b1JiazNFNnFqSWdUVzkrNzN2L3dFZDNxWFAvMmU2Yjc2?=
 =?utf-8?B?RlA0ZmhUNEhVUHdTRGlOOUplSUFPWEdsWlpwN1IzUGt4VVU4QUJTQ2VzUHRv?=
 =?utf-8?B?dEQ4Q3krendMUC9Ba2ZFbVVBRDhvRGtUQzNocUV5cXFIVUNGZmVDYkJTMDRn?=
 =?utf-8?B?ei9SQnUwd241UlN0UWpyb09Hd3lLQ25xVnM4MW5uY0lkN0hneWc0UDBKeGlL?=
 =?utf-8?B?QlBvcjdvdU00U0tZTGJPK016N01GYlBheU13aFRYM2tHYnNpOWJPMFA1VXAv?=
 =?utf-8?B?cjcvbkpIV29TZFpUcFdXVmJvRU1haHZaNFNOUzNONUVFNXpDYnRZME1JM0kx?=
 =?utf-8?B?Ky8zZS9vR1ZUN2NiYmdnQ1NQQVpQRktsc1IzVDZGNjVjN3lHN2NsR3dnN01K?=
 =?utf-8?B?b04yZGVUa01VdUdzazRrMXZ1RnZ6V0JRazIzdStLZ2UwdnBJR2lUeVp3YTh0?=
 =?utf-8?B?d1lOaWRxdzVUcC9hYkdJQmRLbjFzcy9LdDV3NmNmWDJkaW5KOUQ1S0RMVjgy?=
 =?utf-8?B?VmRxT1oxZmJxTVNnQWRVcDlNVFlHeHNaWkZnL01uTlJxMUprK1FBVmJBczd5?=
 =?utf-8?B?bUlrcU1taUV5SWgxMG9YTXIrMHdzQWZXQVJBQ2lVbVYxK0V5V2haczhkUzJl?=
 =?utf-8?B?WjI3ekxrUklBUmxpdmIzQlB4TFMyNk8xalVqaStTKzduUjZBVVYwajA4VDNj?=
 =?utf-8?B?bGhZTFkvMm10alJSaGhmSUc2UTREQXg2SVV6RzQzR2xjVlQ0QWdjdDJva3dI?=
 =?utf-8?B?UEFKdFR6MTYzVDVOa0hLNmgxWlpsRWFZTzdIckhBZjlmcVIyUTVKZzlHd3VT?=
 =?utf-8?B?TlowRnZYWE0rQmIyRUM5eDdkMVc3M01PVVJDT3JuYnNhcmZoZDl6Uk9qc2gy?=
 =?utf-8?B?dGZiLytFSTR0d25ubE1yWHIrUk5FQWo3SDZsZWh4bTBiRDRCeWJ2MlV6OFJx?=
 =?utf-8?B?ZFRuTTlCUERJVXJZeTFoa1AvK0xJdVVwTjhhUGdEU0htd0xWV2doN1Q1M25p?=
 =?utf-8?B?RTR4V1Irc2luVkJ4d0NtYy9OdWVMT2poZEVHUlhJek12YytIalBwU3VMTHFX?=
 =?utf-8?B?VGdMTnVRVHQrSVJoaGxGa3pzRklaNDFRL3hpSTUwNHFDS3FsOTgxbGU0Q2Jv?=
 =?utf-8?B?Uzh2QW9zaXNMSk9ZZnJoYW1Ba3hBUXZsWW9IUXd0SzJQMTUweisxVHQyRGRo?=
 =?utf-8?B?V2JERWphU3R3PT0=?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad8bf6a-5581-4c10-c134-08da08be9849
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 09:06:31.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rta8kzdS77l7Dphs9Pk6AlrIuWGl8bC9Wv0bEByTzKDhKxy6VE++cVBQDUAhFmbNJ+lE0XS4f0sN8jz78bY49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms020204040904070104010800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2022-03-16 16:47, Dave Hansen wrote:
> On 3/16/22 03:24, Jethro Beekman wrote:
>>> Doing this automatically and unconditionally during a microcode
>>> update seems undesirable. This requires the userland tooling that
>>> is coordinating the microcode update to be aware of any SGX
>>> enclaves that are running and possibly coordinate sequencing with
>>> the processes containing those enclaves. This coupling does not
>>> exist today.
>> Also, a microcode update may not affect SGX security at all and doing
>> the EUPDATESVN procedure may not be required for this particular
>> update. This case is called out specifically in the EUPDATESVN
>> documentation.
> 
> I don't think Intel provides the metadata for the kernel to tell if an
> update requires an EUPDATESVN procedure or not.  If this is inconvenient
> for you, I'd suggest reporting this to the folks at Intel who can fix
> it.  It doesn't seem like something which they are motivated to fix.

Whether or not metadata is currently made available is orthogonal to creating a mechanism by which userspace can indidate that a particular microcode update shouldn't trigger the EUPDATESVN procedure.

--
Jethro Beekman | Fortanix

--------------ms020204040904070104010800
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAo
rKRKpFwMN77KaahISgU8MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAzMTgwOTA2MjVaMC8GCSqGSIb3DQEJBDEiBCC3
FFG2ZiZLsVuLksB1xrELspPRCX6YEWBwSlOi1+yCVDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCECispEqkXAw3vsppqEhKBTwwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAorKRKpFwMN77KaahISgU8MA0G
CSqGSIb3DQEBAQUABIIBAG4rItSJrFejLpjcdggbr+CNXjQxoSVlOqxxdD2kJprBDUJFWDet
1y/1rVAe51KWKQqQs81pBnhNirBJDjLGFMqtfge6/L9X+CAGH2TN8H6C2PnrBjkhhfHHLDCk
HyCLi5zs69fui1g2ZpdbqMnyJi2Jh0LPI6hMtaHFoS7m8aumhuk2/wbruDJ0m4h4i7qiPo0/
8d3fznXGIkz49jsIwfc/5ejd6p5YLaa1akTnw6LRUQ2EWSQ82hSUArWBx5AwkHKet98JGkAt
+UmTBaEzCVg08Ds02/A1ucAT60a9fiq2v61YEx/b/nb5QA7chmA6NOL2BK9ZQhVqKQRZ32ch
1CkAAAAAAAA=

--------------ms020204040904070104010800--
