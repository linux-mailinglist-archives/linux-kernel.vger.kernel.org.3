Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B315A1E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiHZBbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiHZBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:31:02 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C44D4FB;
        Thu, 25 Aug 2022 18:30:58 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PNnlni019375;
        Thu, 25 Aug 2022 18:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=N6ap1JzJITRZ9l2H3/GQ932nCGlbvB+qCZcUq92zlok=;
 b=WROnCwcM8n/5WcjF7qXqBdcvC30wkQdOQaNy+ptf2SckYEuwp2mF6Ju7nolzX3Z5Nl4L
 GbvmR2SYdbUvvUinzkQA7O2I38HcI/3TbTRXzWclaJSeCNVhSCIaUcvayo3bPcOkbDjw
 F1ehu8x4mcY3gJsDiY9S7tdGB32VXOKyKxT7EAjiVPinAylv0nBgEnQTVuJckSxUrQ8A
 jljUDePGFayPf2Ie2a+zPbf6FpLTmURER4zFnQu90LXOgy+zRiR56s7dBmyILHX9L5I7
 8UZejVPU6j/toJ2Lg6ugOiLP09oahDInd4HIIXrtIxu/HZggxxTfETcSEi3ViHcptRSZ 9A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j5a42q4nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 18:30:45 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C1BD0C00F3;
        Fri, 26 Aug 2022 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661477445; bh=N6ap1JzJITRZ9l2H3/GQ932nCGlbvB+qCZcUq92zlok=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dpyB8os463yos9Mx6TdZM2UYxos79Lqh0QueWY2iBJ8YTyvuBr6/o4i85wqgGt0Iv
         SU6feRFjYu81zcDf5GXx+YGVikD4Vjhd7cl2sQv2PiPsrMeWsz78PGrHp/6J7T9tS/
         dw96fiFGCRxwJ7QUHjRel2LHvKXrmp3fVAevq9HXi/jFE1623hz9ZEG7L/OGoSk8pp
         +H065qSqPdHH607xgeD1Sj8BoX60VXeOXOG1apThXxEsOKHBQIa0guhdaNKhjQkqXK
         dYwrJW1hg1a0EMu9LAYpyAB8iWgdHfb/zRoiveAEcKABDitd80HEHlAvB+8LaJDAn7
         ZWbI3a6LnALsA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9C705A0081;
        Fri, 26 Aug 2022 01:30:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 189F4400BA;
        Fri, 26 Aug 2022 01:30:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RV1NmeIA";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU5wQfaQq9E+z5ZcKND8C53lfR4ORQfYf54ZXt7HFwzk5zq5iSf9+IQZP6tCxRwG25kRJu7TqamOYgSeSGZ2NAFw8JFnf5mfBAoZ8xjJpmfVEzJTow5eo9A9rNJ/ioDMv39ChKoVVhXjPjn6ihix876e/GNoDd12yETYvcyobQYVzEbuZcLJVmi3NHkdcF8Fqhj+xBvPC/YAegmxxfUiKUs7f/l9zt5m2+BzsAW2qp/pyQkGLF1+S5Ch1N5+LvLh8XEtFRCGPumNyToo/jgR+8R8ZCLQRATYaq9ryuFWdjk3f4AetzlOad9Bb9vM5VOhuNVzSQP6s2bP5yI3Wsw/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6ap1JzJITRZ9l2H3/GQ932nCGlbvB+qCZcUq92zlok=;
 b=QX2ioCW0Ikuutxk2/JvMmkt+KT45sjKLqAjUesJr5KZ0O01LrRfMtuGWSaH7rvIzTQHVXysKmcBVuEDNYp7d856WP1vbwa0gXDN+8NcnZISMfftUgrVuf1bY/CME8wihNFgx1XzKXnWmm7iKWQ4uqJ78Yis/nkP4MAsra0IN24F998xBKnwzbDARcGe5Eg28TjWQwE9cTLLt5CUhPCSpV+/iMzJHk2D7OBQe4w3yTL8p2C5ha7C6oD/x5n8Ac/DhbFpPgQ5qMj8zPRTrXCedO9w5AU4bd4c23CS1umVDJ4F8kBTiDQdN+XKbvovVTXnAL3xzkZR/8pjrwNXj6DTMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ap1JzJITRZ9l2H3/GQ932nCGlbvB+qCZcUq92zlok=;
 b=RV1NmeIA3q1iStn5a/bV331q31mhiHF2RCXbonXnGJpAnXTkYVmmuGRbyJrwYmV7fR1WMWmPVGXZWSalN17wm43u7lwtuYXd+yajxCJrp4KK6udtcsCdKvvh9iDNJd6wf3uSR5kG9wy2oT+zdxBqmsbhQ4lfvPSTGDh0QvNY9nY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 01:30:39 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 01:30:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4CAAXhZgIAF+LQAgABBaYCAAsdLAIAGuhMAgAFhiYCAA12tgA==
Date:   Fri, 26 Aug 2022 01:30:38 +0000
Message-ID: <20220826013021.xrvhi3xrgyz2dkin@synopsys.com>
References: <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
 <20220823010056.5yvd6223awab47vl@synopsys.com>
 <281aae0d-6146-bf65-cf23-2ddf7e16ae1c@quicinc.com>
In-Reply-To: <281aae0d-6146-bf65-cf23-2ddf7e16ae1c@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eecad11-7ec8-45fb-30d7-08da8702954b
x-ms-traffictypediagnostic: CH0PR12MB5314:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mv/6oEbLsBsZdLDpHDaZDpNoEOyVeDWVoKBMTVUwfnpOTYbtRfxBEKcQxPUoIcUgrxo9KbFD9CkaZbWjV7xDOjG1ajQF8uSZC9rqujAdu89av+OpLZkX1Liz8zAg6v2Jrd0/ilo17DF0RZa8ukk1BAqYppQ9G/6+LYubNW3Ry62GLVLZiWd+lCJrSz8nJ46+nSQQQWOutU+Kf6nc7tsG/Q5g2Y8mRA1i9TgCLhR5VylJaqsVI41XgCK7Ye8XZZDYehTGRRsnpvM3AVgN2X1JZJvG/1jnE1jFG069uHbvRAy9wKrtxPU+Gu8TQChgx9a7Y0n/sM19KXIIAXgI3dqeFXGjahfw3RLT/+EW+dmyfkDHi4OGpfS22CyuSUqbz88OLmhLwa4P0J58I/TL3zAgg2NbPZKktzcQd3cIuY2mH2kZy6az5mhiUsOdOy+wGmc9QoMQAt2U66ytFHhrH956fXE6xewEsrmzEHhw9z4/vTOdIvzBx65uKmdzme2bkm6b0gzBMl8nDT/JrhJtLR+RHTjVdD0l22sMApG+JiR9ObWK+GgifWVmq/upZjvuYCNJ3wmJSsd+T5PY1maTpVypwLVQ5be3moebPtvgd+gtRLyUhd2FCEcfe7F4bh7A4au3eytpM5Pp80QTbMQqBnLT453nSdPYjxxylFmH81NDlwvl1mo7zGTpnnIFfR3fQlXroXL0qOkputMmDJMwnmv8z1pmfYT4JT4G2xAuPHTfHCVRpg7+SVylcss3KMgTCdr9UQGcypxBRAvqn63tbei4NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(376002)(136003)(5660300002)(71200400001)(6486002)(6506007)(478600001)(26005)(53546011)(6512007)(83380400001)(1076003)(2906002)(8936002)(186003)(316002)(30864003)(54906003)(6916009)(2616005)(76116006)(8676002)(4326008)(122000001)(64756008)(41300700001)(86362001)(66446008)(66556008)(66476007)(38100700002)(66946007)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5PM1dmQTFRVVpyTTN4T3FqY3BxMU0zMC81S3ZJU0gyeS9CZUZZZzFZamJL?=
 =?utf-8?B?WVM1endIbXAyRHcyTWI1cGhaNzd6d1RYRmZ2bEdHV0h0OTN2Z0wyK3Q0NHAy?=
 =?utf-8?B?Y2JyTmZyeENkU1ZMSXpiemFaTmhMK05TbHJ1WUcvc1ZoVmEzWmpDQ1JDSC9q?=
 =?utf-8?B?WFR5bWk1RmQ0SEd6eVhOWmYrK0ZLaVIwREcrUkxXemVNYjBpVS9oMWVzWDQ3?=
 =?utf-8?B?NEF0Sm9vMk92N283cTFjQk5BUjZCV1VEaHB5aXJndHB0dm5UOXdwbXdHb1Rt?=
 =?utf-8?B?N3M0UkRhNDhHcWpjUTZvL3FoMnVWdFhoZlBTNWpQUFF3c3d5bit5UjVJdnV5?=
 =?utf-8?B?bktNYnhHQSs0RUtDZldWdGZDcjFnMGQ1SjgrdGlPS1Q0ZmdacHV5MkFnZVZP?=
 =?utf-8?B?UjNsNXMwRUJUVERmUmlWQUc1MTJwZzlKS0ErSFBRTHJXa2VCc3ByTkdOYitH?=
 =?utf-8?B?YjhpbWs3cTltNVdYbWloaTVmcFErcEM0Y0MrVG5EZFlMb1pNYy9mRERBV3Z6?=
 =?utf-8?B?STZlK1FxblJRN0tEa2tvL0NoSWZNZUZBZCtDZWZEcTVXeTUzMThpMy9EY210?=
 =?utf-8?B?UmZjSHZQemJ6eFNrR1k0MHFUK3p2UkZRazlreUQ0L3lWcEl4UlZjcS9tODVN?=
 =?utf-8?B?SElXUFM0S1QrSGZ5VElTS3RDdld6VjYwakhlUW5qaUxmZXh5cWwvcm9FZGE1?=
 =?utf-8?B?RlN2Y2d4dExOKzlzUS9tYXR3Ym96Rk9RS05sQzZ0VFY4bUE1NDdzR3lrRHI4?=
 =?utf-8?B?U0pFQWR5V3FQOEVWWDRCWTE0N1dPamFlNWltYWJvOE5zc1FHT3hFRDlJMEVy?=
 =?utf-8?B?VVJDcDhTeG4rZ3h4ZUtGSnhwVVlKSFUvWVJUbkVnY3RUaVVHMkloZlowbkV5?=
 =?utf-8?B?MWlIbHRqR3hDbGh5QWw1TkdSMGlndnBxQWFvN2xtZnprb3hZcm9mU1dGWEVI?=
 =?utf-8?B?em10MHV0K1IxU09mTXpBV1dTbGFXWHVITUFSbWF0QXdNbDIrcFZXMlM2VVNC?=
 =?utf-8?B?eUhCTzFVb3d6ZG52QVhoZ2RPelowaDdCUVY5ejdneUdOU1RiQlRXd3R4L1Vi?=
 =?utf-8?B?VXVobmJkS0tMYmE4YWJhODROdU5JWmpEdk1wTk5WZ2daV0MxREhvdjlndUlw?=
 =?utf-8?B?TnNnL0pZcTdubFRVWXgrNndnZTVjRTRHUmFSa3lDdmdLb3FSRFI0a1d3b2xu?=
 =?utf-8?B?ejBjeUx6VC81bDhBR01CVVU0a3pFTm9BWlNzRVpNOFJJcVlNQmVhWnRTdGpx?=
 =?utf-8?B?S0gvKzhxYWJmd2dzSWpOdW5jVDdlZ3FReEZwVis2MStERDhHTDYrbC9MdWlB?=
 =?utf-8?B?d24zVlBYb1dHRUgra3AvZnlnWHFpWDdzSjhldUVxWXJnTVIzVlkzRnJIWFJq?=
 =?utf-8?B?ZnFtNDlLR1cxYTh0TFduMFVnS0ZRZzk1SEZRUDFta0cweWU5Q3Z3OS9ERmhZ?=
 =?utf-8?B?WUtuVFRlUFJRbUpESWYvT1k1cnM3TFEyOHArM2FkeTNOUzV2and1d1lLK2N2?=
 =?utf-8?B?amgvQmJwSG9WZzVWbUp6Z09qWXdvOGZIVE8xS3NPck9LcGlUemxjd3FheWxR?=
 =?utf-8?B?V0ZGaFMyclVBaXp6SnZ1ODhIVlhucnhZbFlnTUxBWlhJR1ZIZmpUQkVCZmtK?=
 =?utf-8?B?Z0JxTm4renJubXZDK2VWdGExWWtsM2ZGR1h0d3d1TVNuRzFKamdIYkxYUjIz?=
 =?utf-8?B?UUV4R0dIcU5wa0lrR0c5c3N0bkdVcjFqdXkreWF6NDlydnd5L3htWm9HVVBs?=
 =?utf-8?B?TFVRdVV3L0YrcGZHYTNNRTV1aHNuckVYMFAzYXkrMjVzdVlBaERaOFhyL1VM?=
 =?utf-8?B?dklzalFCd1dZaHRxNHVvb1d4YnA5ZjZrb0I0aXZTSmJNekJFZXp4ajZzWXJz?=
 =?utf-8?B?b0ZkZ0s3Wk1GWmJ3dEJMeGY1VE9pMkV2c2dPMmZiNnpIdG9FMVhLZllHQ01Q?=
 =?utf-8?B?ZkVIUzRRRExGQjlhWHpMMVJRcXpDRHpGVlA1RVM4eWZlTTcxbUVhZ000NVY4?=
 =?utf-8?B?b0lnbzlaYTFIL1VvQ003KzcxTzRibHBSWG9Fc2dpMVlYc2RkdERtZ0duRGpw?=
 =?utf-8?B?bHVKemZrcnlOZ2xLRnR6VXFrNnd3NC84Y3BSQXhWd2ZIYmkzZ2JRRXdtclVY?=
 =?utf-8?Q?ahuzQFjvp8rA8P9ZLHZXjZpZi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE69236856A61242827C93FC41E30380@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eecad11-7ec8-45fb-30d7-08da8702954b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 01:30:39.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCzLsAzSv/9woQWfDBNWymcsGySdannc6Old9XxJHfxPZKE1Ua936Li3ggWnyBOJyMP8OTFSHqcZ5YBIq3LhVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Proofpoint-GUID: BXdzeAARiuGztSOaVjTDP3zCnvjU1RJd
X-Proofpoint-ORIG-GUID: BXdzeAARiuGztSOaVjTDP3zCnvjU1RJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMjMsIDIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gT24gOC8yMi8yMDIy
IDY6MDEgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBh
dCAxMToxNzoyNEFNIC0wNzAwLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gT24gOC8xNi8yMDIyIDQ6NTEgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4g
T24gOC8xNi8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gT24gOC8xMi8yMDIyIDU6NDYgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
PiA+ID4gPiA+IE9uIDgvMTEvMjAyMiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBPbiA4LzExLzIwMjIsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBPbiA4
LzExLzIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBPbiA4LzkvMjAyMiA2OjA4IFBNLCBUaGlu
aCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPHNuaXA+
DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IFRvIHN1bW1hcml6ZSB0aGUgcG9pbnRzOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+ID4gMSkgVGhlIGhvc3Qgb25seSBhcm1zIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAg
aWYgdGhlIGRldmljZSBpcw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBjYXBhYmxlIG9mDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IHJlbW90ZSB3YWtldXAgKGNoZWNrIFVTQl9DT05GSUdfQVRUX1dBS0VVUCBp
biBibUF0dHJpYnV0ZXMgYW5kDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGhhcmR3YXJlDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IGNhcGFiaWxpdHkpDQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+ID4gPiAyKSBJZiB0aGUgZGV2aWNlIGlzIGluIHN1c3BlbmQsIHRoZSBkZXZpY2UgY2Fu
IGRvIHJlbW90ZSB3YWtldXANCj4gPiA+ID4gPiA+ID4gPiA+ID4gKHRocm91Z2gNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gTEZQUyBoYW5kc2hha2UpIGlmIHRoZSBmdW5jdGlvbiBpcyBhcm1lZCBmb3Ig
cmVtb3RlIHdha2V1cCAodGhyb3VnaA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBTRVRfRkVBVFVSRShG
VU5DX1NVU1BFTkQpKS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IDMpIElmIHRoZSBsaW5rIHRyYW5zaXRpb25zIHRvIFUwIGFmdGVyIHRoZSBkZXZpY2UgdHJpZ2dl
cmluZyBhIHJlbW90ZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiB3YWtldXAsIHRoZSBkZXZpY2Ugd2ls
bCBhbHNvIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiBmdW5jdGlvbg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiB3YWtlIGZvcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBhbGwgdGhlIGludGVyZmFjZXMgYXJt
ZWQgd2l0aCByZW1vdGUgd2FrZXVwLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiA+ID4gNCkgSWYgdGhlIGRldmljZSBpcyBub3QgaW4gc3VzcGVuZCwgdGhlIGRldmljZSBj
YW4gc2VuZCBkZXZpY2UNCj4gPiA+ID4gPiA+ID4gPiA+ID4gbm90aWZpY2F0aW9uIGZ1bmN0aW9u
IHdha2UgaWYgaXQncyBpbiBVMC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBOb3csIHJlbW90ZSB3YWtldXAgYW5kIGZ1bmN0
aW9uIHdha2UgZGV2aWNlIG5vdGlmaWNhdGlvbiBhcmUgMg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBz
ZXBhcmF0ZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBvcGVyYXRpb25zLiBXZSBoYXZlIHRoZSB1c2Jf
Z2FkZ2V0X29wcy0+d2FrZXVwKCkgZm9yIHJlbW90ZSB3YWtldXAuIEkNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gc3VnZ2VzdGVkIHRvIG1heWJlIGFkZA0KPiA+ID4gPiA+ID4gPiA+ID4gPiB1c2JfZ2Fk
Z2V0X29wcy0+c2VuZF93YWtldXBfbm90aWZpY2F0aW9uKGdhZGdldCwNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gaW50Zl9pZCkgZm9yIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uLiBXaGF0IHlvdSBkaWQg
d2FzIGNvbWJpbmluZyBib3RoDQo+ID4gPiA+ID4gPiA+ID4gPiA+IG9wZXJhdGlvbnMgaW4gdXNi
X2dhZGdldF9vcHMtPmZ1bmNfd2FrZXVwKCkuIFRoYXQgbWF5IG9ubHkgd29yayBmb3INCj4gPiA+
ID4gPiA+ID4gPiA+ID4gcG9pbnQgNCkgKGFzc3VtaW5nIHlvdSBmaXggdGhlIFUwIGNoZWNrKSwg
YnV0IG5vdCBwb2ludCAzKS4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4g
VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIGFuZCBzdW1tYXJ5LiBJIHdpbGwgcmVuYW1lIGZ1
bmNfd2FrZXVwIHRvDQo+ID4gPiA+ID4gPiA+ID4gPiBzZW5kX3dha2V1cF9ub3RpZmljYXRpb24g
dG8gYmV0dGVyIGFsaWduIHdpdGggdGhlIGFwcHJvYWNoLiBUaGUNCj4gPiA+ID4gPiA+ID4gPiA+
IHJlYXNvbiBJDQo+ID4gPiA+ID4gPiA+ID4gPiBoYXZlIGNvbWJpbmVkIHJlbW90ZV93YWtldXAg
YW5kIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIGluDQo+ID4gPiA+ID4gPiA+ID4gPiB1c2Jf
Z2FkZ2V0X29wcy0+ZnVuY193YWtldXAoKSBpcyBiZWNhdXNlIHNpbmNlIHRoZSBpbXBsZW1lbnRh
dGlvbg0KPiA+ID4gPiA+ID4gPiA+ID4gaXMgYXQNCj4gPiA+ID4gPiA+ID4gPiA+IGZ1bmN0aW9u
L2NvbXBvc2l0ZSBsZXZlbCBpdCBoYXMgbm8ga25vd2xlZGdlIG9uIHRoZSBsaW5rIHN0YXRlLiBT
byBJDQo+ID4gPiA+ID4gPiA+ID4gPiBoYXZlIGRlbGVnYXRlZCB0aGF0IHRhc2sgdG8gY29udHJv
bGxlciBkcml2ZXIgdG8gaGFuZGxlIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gbm90aWZpY2F0aW9u
DQo+ID4gPiA+ID4gPiA+ID4gPiBhY2NvcmRpbmdseS4gVGhhdCBpcyBkbyBhIExGUFMgaGFuZHNo
YWtlIGZpcnN0IGlmIHRoZSBkZXZpY2UgaXMNCj4gPiA+ID4gPiA+ID4gPiA+IHN1c3BlbmRlZCBh
bmQgdGhlbiBzZW5kIG5vdGlmaWNhdGlvbiAoZXhwbGFpbmVkIGJlbG93KS4gQnV0IHdlIGNhbg0K
PiA+ID4gPiA+ID4gPiA+ID4gZGVmaW5pdGVseSBzZXBhcmF0ZSB0aGlzIGJ5IGFkZGluZyBhbiBh
ZGRpdGlvbmFsIGZsYWcgaW4gdGhlIGNvbXBvc2l0ZQ0KPiA+ID4gPiA+ID4gPiA+ID4gbGF5ZXIg
dG8gc2V0IHRoZSBsaW5rIHN0YXRlIGJhc2VkIG9uIHRoZSBnYWRnZXQgc3VzcGVuZCBjYWxsYmFj
aw0KPiA+ID4gPiA+ID4gPiA+ID4gY2FsbGVkDQo+ID4gPiA+ID4gPiA+ID4gPiB3aGVuIFUzIFNV
U1BFTkQgaW50ZXJydXB0IGlzIHJlY2VpdmVkLiBMZXQgbWUga25vdyBpZiB5b3UgZmVlbA0KPiA+
ID4gPiA+ID4gPiA+ID4gc2VwYXJhdGluZyB0aGUgdHdvIGlzIGEgYmV0dGVyIGFwcHJvYWNoLg0K
PiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gVGhl
IHJlYXNvbiBJIHRoaW5rIHdlIG5lZWQgdG8gc2VwYXJhdGUgaXQgaXMgYmVjYXVzZSBvZiBwb2lu
dCAzLiBBcyBJDQo+ID4gPiA+ID4gPiA+ID4gbm90ZSBlYXJsaWVyLCB0aGUgc3BlYyBzdGF0ZXMg
dGhhdCAiSWYgcmVtb3RlIHdha2UgZXZlbnQgb2NjdXJzIGluDQo+ID4gPiA+ID4gPiA+ID4gbXVs
dGlwbGUgZnVuY3Rpb25zLCBlYWNoIGZ1bmN0aW9uIHNoYWxsIHNlbmQgYSBGdW5jdGlvbiBXYWtl
DQo+ID4gPiA+ID4gPiA+ID4gTm90aWZpY2F0aW9uLiINCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBCdXQgaWYgdGhlcmUncyBubyByZW1vdGUgd2FrZSBldmVudCwgYW5kIHRoZSBo
b3N0IGJyb3VnaHQgdGhlIGRldmljZSB1cA0KPiA+ID4gPiA+ID4gPiA+IGluc3RlYWQsIHRoZW4g
dGhlIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaXMgcmV0YWluZWQuDQo+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gSWYgd2Ugc2VwYXJhdGUgdGhlc2UgMiBvcGVyYXRpb25zLCB0aGUg
Y2FsbGVyIGNhbiBjaGVjayB3aGV0aGVyIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IG9wZXJhdGlvbiB3
ZW50IHRocm91Z2ggcHJvcGVybHkuIEZvciBleGFtcGxlLCBpZiB0aGUgd2FrZXVwKCkgaXMNCj4g
PiA+ID4gPiA+ID4gPiBpbml0aWF0ZWQgcHJvcGVybHksIGJ1dCB0aGUgZnVuY3Rpb24gd2FrZSBk
ZXZpY2Ugbm90aWZpY2F0aW9uIGRpZG4ndCBnbw0KPiA+ID4gPiA+ID4gPiA+IHRocm91Z2guIFdl
IHdvdWxkIG9ubHkgbmVlZCB0byByZXNlbmQgdGhlIGRldmljZSBub3RpZmljYXRpb24gcmF0aGVy
DQo+ID4gPiA+ID4gPiA+ID4gdGhhbiBpbml0aWF0ZSByZW1vdGUgd2FrZXVwIGFnYWluLg0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSWYgd2UgZG9uJ3QgaGF2ZSB0byBzZW5kIGRldmlj
ZSBub3RpZmljYXRpb24gZm9yIG90aGVyIGludGVyZmFjZXMsIHdlDQo+ID4gPiA+ID4gPiA+IGNh
biBjb21iaW5lIHRoZSBvcGVyYXRpb25zIGhlcmUgYXMgeW91IGRpZC4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgc3RpbGwgdGhpbmsgaXQncyBiZXR0ZXIgdG8g
c3BsaXQgdXAgdGhlIG9wZXJhdGlvbnMuIFRoZSB3YXkgeW91J3JlDQo+ID4gPiA+ID4gPiBoYW5k
bGluZyBpdCBub3cgaXMgbm90IGNsZWFyLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJZiB0
aGUgZnVuY19hd2FrZSgpIHJldHVybnMgLUVBR0FJTiwgSSdkIGV4cGVjdCB0aGF0IHRoZSByZW1v
dGUgd2FrZSBkaWQNCj4gPiA+ID4gPiA+IG5vdCBnbyB0aHJvdWdoIGFuZCBleHBlY3QgdXNlciB0
byByZXRyeSBhZ2Fpbi4gQnV0IGhlcmUgaXQgZG9lcyBpbml0aWF0ZQ0KPiA+ID4gPiA+ID4gcmVt
b3RlIHdha2UsIGJ1dCBpdCBqdXN0IGRvZXMgbm90IHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiB5
ZXQuIFRoaXMgaXMNCj4gPiA+ID4gPiA+IGNvbmZ1c2luZy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gQWxzbywgaW5zdGVhZCBvZiBhbGwgdGhlIGZ1bmN0aW9uIHdha2UgaGFuZGxpbmcgY29t
aW5nIGZyb20gdGhlIGZ1bmN0aW9uDQo+ID4gPiA+ID4gPiBkcml2ZXIsIG5vdyB3ZSBkZXBlbmQg
b24gdGhlIGNvbnRyb2xsZXIgZHJpdmVyIHRvIGNhbGwgZnVuY3Rpb24gcmVzdW1lKCkNCj4gPiA+
ID4gPiA+IG9uIHN0YXRlIGNoYW5nZSB0byBVMCwgd2hpY2ggd2lsbCB0cmlnZ2VyIGRldmljZSBu
b3RpZmljYXRpb24uIFdoYXQNCj4gPiA+ID4gPiA+IGhhcHBlbiBpZiBpdCBkb2Vzbid0IGNhbGwg
cmVzdW1lKCkuIFRoZXJlJ3MgdG9vIG1hbnkgZGVwZW5kZW5jaWVzIGFuZCBpdA0KPiA+ID4gPiA+
ID4gc2VlbXMgZnJhZ2lsZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSB0aGluayBhbGwg
dGhpcyBjYW4gYmUgaGFuZGxlZCBpbiB0aGUgZnVuY3Rpb24gZHJpdmVyLiBZb3UgY2FuIGZpeCB0
aGUNCj4gPiA+ID4gPiA+IGR3YzMgd2FrZXVwKCkgYW5kIHBvbGwgZm9yIFUwL09OIHN0YXRlIHJh
dGhlciB0aGFuIFJFQ09WRVJZIHN0YXRlLCB3aGljaA0KPiA+ID4gPiA+ID4gaXMgd2hhdCBpdCdz
IHN1cHBvc2VkIHRvIHBvbGwuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRm9yIHRyYW5zaXRpb25p
bmcgZnJvbSBVMyB0byBVMCwgdGhlIGN1cnJlbnQgdXBzdHJlYW0gaW1wbGVtZW50YXRpb24gaXMN
Cj4gPiA+ID4gPiB0byBwb2xsIGZvciBVMCBzdGF0ZSB3aGVuIGR3YzNfZ2FkZ2V0X3dha2V1cCgp
IGlzIGNhbGxlZCBhbmQgaXQgaXMgYQ0KPiA+ID4gPiA+IGJsb2NraW5nIGNhbGwuICh0aGlzIGlz
IGEgY29tbW9uIEFQSSBmb3IgYm90aCBIUyBhbmQgU1MpDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
ICDCoMKgwqDCoC8qIHBvbGwgdW50aWwgTGluayBTdGF0ZSBjaGFuZ2VzIHRvIE9OICovDQo+ID4g
PiA+ID4gICDCoMKgwqDCoHJldHJpZXMgPSAyMDAwMDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAg
IMKgwqDCoMKgd2hpbGUgKHJldHJpZXMtLSkgew0KPiA+ID4gPiA+ICAgwqDCoMKgwqDCoMKgwqAg
cmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gICDCoMKgwqDCoMKgwqDCoCAvKiBpbiBIUywgbWVhbnMgT04gKi8NCj4gPiA+ID4gPiAg
IMKgwqDCoMKgwqDCoMKgIGlmIChEV0MzX0RTVFNfVVNCTE5LU1QocmVnKSA9PSBEV0MzX0xJTktf
U1RBVEVfVTApDQo+ID4gPiA+ID4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+
ID4gPiA+ICAgwqDCoMKgwqB9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW4gbXkgZXhwZXJpbWVu
dHMgSSBmb3VuZCB0aGF0IGNlcnRhaW4gaG9zdHMgdGFrZSBsb25nZXIgdGltZSB0byBkcml2ZQ0K
PiA+ID4gPiA+IEhTIHJlc3VtZSBzaWduYWxsaW5nIGJldHdlZW4gdGhlIHJlbW90ZSB3YWtldXAg
YW5kIHRoZSByZXN1bWUgSyBhbmQgdGhpcw0KPiA+ID4gPiA+IHRpbWUgdmFyaWVzIGFjcm9zcyBo
b3N0cy4gSGVuY2UgdGhlIGFib3ZlIHBvbGxpbmcgdGltZXIgaXMgbm90IGdlbmVyaWMNCj4gPiA+
ID4gPiBhY3Jvc3MgaG9zdHMuIFNvIGhvdyBkbyB3ZSBjb252ZXJnZSBvbiBhIHBvbGxpbmcgdGlt
ZXIgdmFsdWUgdG8gd29yaw0KPiA+ID4gPiA+IGFjcm9zcyBIUy9TUyBhbmQgd2l0aG91dCBibG9j
a2luZyB0aGUgc3lzdGVtIGZvciBhIGxvbmcgdGltZT8NCj4gPiA+ID4gDQo+ID4gPiA+IENhbid0
IHdlIHRha2UgdGhlIHVwcGVyIGxpbWl0IG9mIGJvdGggYmFzZSBvbiBleHBlcmltZW50PyBBbmQg
aXQNCj4gPiA+ID4gc2hvdWxkbid0IGJlIGJsb2NraW5nIHRoZSB3aG9sZSBzeXN0ZW0uDQo+ID4g
PiANCj4gPiA+IE9uIHRoZSBob3N0IEkgd2FzIGV4cGVyaW1lbnRpbmcgd2l0aCwgdGhlIHRpbWUg
aXQgdG9vayB3YXMgYXJvdW5kIDExMG1zIGluDQo+ID4gPiBIUyBjYXNlLiBUaGF0IHdvdWxkIHRy
YW5zbGF0ZSB0byBhIHJldHJ5IGNvdW50IG9mIGFib3V0IH4xODEsMDAwIGluIHRoZQ0KPiA+ID4g
YWJvdmUgcG9sbGluZyBsb29wLiBXb3VsZG4ndCB0aGF0IGJlIGEgdmVyeSBsYXJnZSB2YWx1ZSBm
b3IgcG9sbGluZz8NCj4gPiA+IEFuZCBub3Qgc3VyZSBpZiB0aGVyZSBhcmUgb3RoZXIgaG9zdHMg
dGhhdCB0YWtlIGV2ZW4gbG9uZ2VyIHRpbWUNCj4gPiANCj4gPiBXZSBkb24ndCB3YW50IHRvIHBv
bGwgdGhhdCBtYW55IHRpbWVzLiBXZSBzaG91bGRuJ3QgZGVwZW5kIG9uIHRoZSBkZWxheQ0KPiA+
IG9mIGEgcmVnaXN0ZXIgcmVhZCBmb3IgcG9sbGluZyBpbnRlcnZhbC4gQ2FuJ3Qgd2UganVzdCBz
bGVlcCBpbiBiZXR3ZWVuDQo+ID4gaW50ZXJ2YWwgYXQgYSByZWFzb25hYmxlIGludGVydmFsLg0K
PiA+IA0KPiANCj4gU2xlZXBpbmcgaXMgbm90IGFuIG9wdGlvbiBhcyB0aGUgdXBwZXIgbGF5ZXJz
ICh0aG9zZSBiZXlvbmQNCj4gZnVuY3Rpb24vY29tcG9zaXRlIGxheWVyKSBtYXkgdHJhbnNtaXQg
ZGF0YSB3aXRoIGEgbG9jayBoZWxkLg0KPiANCg0KWW91IGNhbiB1c2UgbWRlbGF5KCkgaWYgaXQg
Y2FuJ3Qgc2xlZXAuIEJ1dCBpZiB0aGUgd2FpdCBpcyBsb25nLCBpdA0Kc2hvdWxkIGJlIGFsbG93
ZWQgdG8gc2xlZXAuDQoNCj4gSSByYW4gaW50byBiZWxvdyBCVUcgd2hlbiByZW1vdGUgd2FrZXVw
IHdhcyB0cmlnZ2VyZWQgdmlhIGEgcGluZygpIGNvbW1hbmQNCj4gYW5kIGF0dGVtcHRlZCBzbGVl
cCB3aGlsZSBwb2xsaW5nDQo+IA0KPiBbICAgODguNjc2Nzg5XVsgIFQzOTJdIEJVRzogc2NoZWR1
bGluZyB3aGlsZSBhdG9taWMNCj4gWyAgIDg4LjkwMDExMl1bICBUMzkyXSBDYWxsIHRyYWNlOg0K
PiA8c25pcD4NCj4gWyAgIDg4LjkxMjc2MF1bICBUMzkyXSAgX19zY2hlZHVsZV9idWcrMHg5MC8w
eDE4OA0KPiBbICAgODguOTE3MzM1XVsgIFQzOTJdICBfX3NjaGVkdWxlKzB4NzE0LzB4YjRjDQo+
IFsgICA4OC45MzA1NjhdWyAgVDM5Ml0gIHNjaGVkdWxlKzB4MTEwLzB4MjA0DQo+IFsgICA4OC45
NDM2MjBdWyAgVDM5Ml0gIHNjaGVkdWxlX3RpbWVvdXQrMHg5NC8weDEzNA0KPiBbICAgODguOTQ4
MzcxXVsgIFQzOTJdICBfX2R3YzNfZ2FkZ2V0X3dha2V1cCsweDFhYy8weDU1OA0KPiBbICAgODgu
OTUzNTU4XVsgIFQzOTJdICBkd2MzX2dhZGdldF93YWtldXArMHgzYy8weDhjDQo+IFsgICA4OC45
NTgzODhdWyAgVDM5Ml0gIHVzYl9nYWRnZXRfd2FrZXVwKzB4NTQvMHgxYTgNCj4gWyAgIDg4Ljk2
MzIyMl1bICBUMzkyXSAgZXRoX3N0YXJ0X3htaXQrMHgxMzAvMHg4MzANCj4gWyAgIDg4Ljk2Nzg3
Nl1bICBUMzkyXSAgeG1pdF9vbmUrMHhmMC8weDM2NA0KPiBbICAgODguOTcxOTEzXVsgIFQzOTJd
ICBzY2hfZGlyZWN0X3htaXQrMHgxODgvMHgzZTQNCj4gWyAgIDg4Ljk3NjY2M11bICBUMzkyXSAg
X19kZXZfeG1pdF9za2IrMHg0ODAvMHg5ODQNCj4gWyAgIDg4Ljk4MTMxOV1bICBUMzkyXSAgX19k
ZXZfcXVldWVfeG1pdCsweDJkNC8weDdkOA0KPiBbICAgODguOTg2MTUxXVsgIFQzOTJdICBuZWln
aF9yZXNvbHZlX291dHB1dCsweDIwOC8weDJmMA0KPiA8c25pcD4NCj4gDQo+IFRoZSBhYm92ZSBl
eHBlcmltZW50IHdhcyBkb25lIGJ5IHJlbW92aW5nIHNwaW5fbG9ja3MgaWYgYW55IGluIHRoZSB3
YWtldXAoKQ0KPiBwYXRoIG9mICBmdW5jdGlvbi9jb21wb3NpdGUvY29udHJvbGxlciBkcml2ZXJz
LiBJdCBpcyBydW5uaW5nIGluIGF0b21pYw0KPiBjb250ZXh0IGR1ZSB0byB0aGUgbG9jayBoZWxk
IGJ5IGxpbnV4IG5ldHdvcmtpbmcgc3RhY2svZ2VuZXJpYyBwYWNrZXQNCj4gc2NoZWR1bGVyLg0K
PiANCj4gU28gYmVsb3cgYXJlIHRoZSBvbmx5IHR3byBhcHByb2FjaGVzIEkgY2FuIHRoaW5rIG9m
IGZvciBkd2MzX2dhZGdldF93YWtldXAoKQ0KPiBBUEkNCj4gDQo+IDEuKVBvbGxpbmcgYmFzZWQg
YXBwcm9hY2g6IFdlIHBvbGwgdW50aWwgdGhlIGxpbmsgY29tZXMgdXAuIEJ1dCBjYW5ub3Qgc2xl
ZXANCj4gd2hpbGUgcG9sbGluZyBkdWUgdG8gYWJvdmUgcmVhc29ucy4NCj4gDQo+IDIuKUludGVy
cnVwdCBiYXNlZCBhcHByb2FjaCAodGhlIHBhdGNoZXMgYmVpbmcgZGlzY3Vzc2VkIGN1cnJlbnRs
eSk6IFdoZW4gYQ0KPiByZW1vdGUgd2FrZXVwIGlzIHRyaWdnZXJlZCBlbmFibGUgbGluayBzdGF0
ZSBpbnRlcnJ1cHRzIGFuZCByZXR1cm4gcmlnaHQNCj4gYXdheS4gVGhlIGZ1bmN0aW9uL2NvbXBv
c2l0ZSBkcml2ZXJzIGFyZSBsYXRlciBub3RpZmllZCBhYm91dCB0aGUgT04gZXZlbnQNCj4gdmlh
IHJlc3VtZSBjYWxsYmFjayAoaW4gYSBzaW1pbGFyIHdheSBob3cgd2Ugbm90aWZ5IFUzIHRvIGNv
bXBvc2l0ZSBsYXllcg0KPiB2aWEgc3VzcGVuZCBjYWxsYmFjaykuDQo+IA0KPiBQbGVhc2UgbGV0
IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55IGFsdGVybmF0ZSB3YXkgdGhhdCB5b3UgY2FuIHRoaW5r
IG9mIGhlcmUuDQo+IA0KDQpUaGUgbWFpbiBpc3N1ZSB3ZSdyZSB0cnlpbmcgdG8gc29sdmUgaXMg
a25vd2luZyBpZiB0aGUgaG9zdCBoYWQgd29rZW4gdXANCmFuZCB0aGUgZGV2aWNlIG5vdGlmaWNh
dGlvbiBpcyBzZW50IHNvIHRoYXQgdGhlIGZ1bmN0aW9uIGRyaXZlciBjYW4NCnJlc3VtZSgpLg0K
DQpJZiB3ZSBjYW4gc2F5IHRoYXQgdXBvbiB1c2JfZ2FkZ2V0X3dha2V1cCgpIHN1Y2Nlc3NmdWwg
Y29tcGxldGlvbiwgdGhlDQpsaW5rIGlzIGluIFUwL09OLCB0aGVuIHRoZSBmdW5jdGlvbiBkcml2
ZXIgY2FuIHNlbmQgdGhlIHdha2UNCm5vdGlmaWNhdGlvbiBhZnRlciBhbmQgcmVzdW1lKCkuIFRo
YXQgaXMsIHdlJ3JlIHRyeWluZyB0byBtYWtlDQp1c2JfZ2FkZ2V0X3dha2V1cCgpIHN5bmNocm9u
b3VzLiBXaGV0aGVyIGl0J3MgcG9sbGluZyBvciBpbnRlcnJ1cHQNCmJhc2VkLCBpdCdzIGltcGxl
bWVudGF0aW9uIGRldGFpbC4NCg0KVW5mb3J0dW5hdGVseSwgdGhlIEFQSSBpc24ndCB2ZXJ5IGNs
ZWFyIHdoZXRoZXIgdXNiX2dhZGdldF93YWtldXAoKSBtYXkNCnNsZWVwIG9yIHN5bmNocm9ub3Vz
Lg0KDQpIZXJlIGFyZSAzIGFwcHJvYWNoZXMgdGhhdCB3ZSBjYW4gaGF2ZToNCg0KMSkgQ2xhcmlm
eSB0aGF0IHVzYl9nYWRnZXRfd2FrZXVwKCkgaXMgc3luY2hyb25vdXMgYW5kIHRoZSBsaW5rIHdp
bGwgYmUNCmluIFUwL09OIHVwb24gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uLCBhbmQgY2xhcmlmeSB3
aGV0aGVyIGl0IGNhbiBzbGVlcC4NCkludHJvZHVjZSBhIHNlcGFyYXRlIEFQSSB1c2JfZ2FkZ2V0
X3NlbmRfd2FrZV9ub3RpZmljYXRpb24oKSB0byBzZW5kDQp3YWtlIG5vdGlmaWNhdGlvbiBzZXBh
cmF0ZWx5Lg0KDQoyKSBDcmVhdGUgYSBuZXcgQVBJIHVzYl9nYWRnZXRfZnVuY3Rpb25fd2FrZXVw
KCkgdGhhdCB3aWxsIGNvbWJpbmUgYm90aA0KZGV2aWNlIHdha2V1cCBhbmQgd2FrZSBub3RpZmlj
YXRpb24uIFRoZSBmdW5jdGlvbiBjYW4gc2xlZXAsDQpzeW5jaHJvbm91cywgYW5kIGJvdGggd2Fr
ZXVwIGFuZCB3YWtlIG5vdGlmaWNhdGlvbiBhcmUgZG9uZSBhZnRlciB0aGUNCmZ1bmN0aW9uIGNv
bXBsZXRlcy4NCg0KMykgQ3JlYXRlIGEgbmV3IEFQSSB1c2JfZ2FkZ2V0X2Z1bmN0aW9uX3dha2V1
cCgpIHRoYXQgd2lsbCBjb21iaW5lIGJvdGgNCmRldmljZSB3YWtldXAgYW5kIHdha2Ugbm90aWZp
Y2F0aW9uLiBUaGUgZnVuY3Rpb24gaXMgYXN5bmNocm9ub3VzLiBXZQ0Kd29uJ3Qga25vdyBpZiB0
aGUgd2FrZXVwIGlzIHN1Y2Nlc3NmdWxseSBzZW50LCBidXQgd2UgZG9uJ3QgY2FyZSBhbmQNCnBy
b2NlZWQgd2l0aCB0aGUgZnVuY3Rpb24gcHJvY2VlZCB3aXRoIHJlc3VtZSgpIGFueXdheS4NCg0K
QlIsDQpUaGluaA0KDQoNCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU29tZSBkYXRh
IGxheWVycyBsaWtlIFRDUC9JUCBob2xkIGEgVFggbG9jayB3aGlsZSBzZW5kaW5nIGRhdGEgKHRo
YXQNCj4gPiA+ID4gPiBjYXVzZXMgYSByZW1vdGUgd2FrZXVwIGV2ZW50KSBhbmQgaGVuY2UgdGhp
cyB3YWtldXAoKSBtYXkgcnVuIGluIGF0b21pYw0KPiA+ID4gPiA+IGNvbnRleHQuDQo+ID4gPiA+
IA0KPiA+ID4gPiBXaHkgaG9sZCB0aGUgbG9jayB3aGlsZSB3YWl0aW5nIGZvciB0aGUgaG9zdCB0
byB3YWtldXA/IFRoZSBob3N0IGlzDQo+ID4gPiA+IHN0aWxsIGluYWN0aXZlLiBBbHNvLCB0aGUg
dXNiX2dhZGdldF93YWtldXAoKSBBUEkgZG9lc24ndCBzcGVjaWZ5IHRoYXQNCj4gPiA+ID4gaXQg
bWF5IHJ1biBpbiBhdG9taWMgY29udGV4dC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoZSBs
b2NrIG1pZ2h0IGJlIGhlbGQgYnkgdXBwZXIgbGF5ZXJzIHdobyBhcmUgdW5hd2FyZS9pbmRlcGVu
ZGVudCBvZg0KPiA+ID4gdW5kZXJseWluZyB0cmFuc3BvcnQgbWVkaXVtLiBUaGUgYWJvdmUgVFgg
bG9jayBJIHdhcyByZWZlcnJpbmcgdG8gd2FzDQo+ID4gPiB0aGF0IGhlbGQgYnkgTGludXggbmV0
d29ya2luZyBzdGFjay4gSXQganVzdCBwdXNoZXMgb3V0IGRhdGEgdGhlIHNhbWUgd2F5IGl0DQo+
ID4gPiB3b3VsZCB3aGVuIFVTQiBpcyBhY3RpdmUuIEl0IGlzIHRoZSBmdW5jdGlvbi9jb21wb3Np
dGUgbGF5ZXIgYmVpbmcgYXdhcmUgb2YNCj4gPiA+IHRoZSBmdW5jdGlvbiBzdXNwZW5kIHdvdWxk
IG5vdyBzZW5zZSB0aGlzIGFzIGEgcmVtb3RlIHdha2UgZXZlbnQgYW5kIHBlcmZvcm0NCj4gPiA+
IHRoaXMgYWRkaXRpb25hbCBzdGVwIG9mIGJyaW5naW5nIG91dCB0aGUgbGluayBmcm9tIHUzIGFu
ZCB0aGVuIHNlbmRpbmcNCj4gPiA+IGRldmljZSB3YWtldXAgbm90aWZpY2F0aW9uLg0KPiA+ID4g
DQo+ID4gPiBJbiBvdXIgY3VycmVudCB1cHN0cmVhbSBpbXBsZW1lbnRhdGlvbiBvZiBkd2MzX2dh
ZGdldF93YWtldXAoKSBBUEkgd2UgaG9sZCBhDQo+ID4gPiBzcGlubG9jayBhcyB3ZWxsLiBCdXQg
eWVhaCB0aGF0IGNhbiBiZSByZWN0aWZpZWQNCj4gPiANCj4gPiBIb2xkaW5nIGEgc3Bpbl9sb2Nr
IGZvciB0aGlzIGxvbmcgaXMgbm90IHJlYXNvbmFibGUuIFdlIG9ubHkgbmVlZCB0bw0KPiA+IGxv
Y2sgd2hlbiBzZXR0aW5nIGxpbmsgcmVjb3ZlcnkgcmVxdWVzdCBidXQgbm90IHdoaWxlIHBvbGxp
bmcgZm9yIERTVFMNCj4gPiBhbmQgd2FpdGluZyBmb3IgdGhlIGxpbmsgdG8gZ28gdXAuDQo+ID4g
DQo+ID4gQlIsDQo+ID4gVGhpbmgNCj4gPiANCj4gPiA+IA0KPiA+ID4gc3RhdGljIGludCBkd2Mz
X2dhZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ID4gPiB7DQo+ID4gPiAJc3Ry
dWN0IGR3YzMJCSpkd2MgPSBnYWRnZXRfdG9fZHdjKGcpOw0KPiA+ID4gCXVuc2lnbmVkIGxvbmcJ
CWZsYWdzOw0KPiA+ID4gCWludAkJCXJldDsNCj4gPiA+IA0KPiA+ID4gCXNwaW5fbG9ja19pcnFz
YXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gPiA+IAlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1
cChkd2MpOw0KPiA+ID4gCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3Mp
Ow0KPiA+ID4gDQo+ID4gPiAJcmV0dXJuIHJldDsNCj4gPiA+IH0NCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gVG8gbWFrZSB0aGlzIGdlbmVyaWMgYWNyb3NzIGhvc3RzLCBJ
IGhhZCBzd2l0Y2hlZCB0byBpbnRlcnJ1cHQgYmFzZWQNCj4gPiA+ID4gPiBhcHByb2FjaCwgZW5h
YmxpbmcgbGluayBzdGF0ZSBldmVudHMgYW5kIHJldHVybiBlcnJvciB2YWx1ZSBpbW1lZGlhdGVs
eQ0KPiA+ID4gPiA+IGZyb20gdGhlIGR3YzNfZ2FkZ2V0X3dha2V1cCgpIEFQSSBhZnRlciBkb2lu
ZyBhIExGUFMgaGFuZHNoYWtlLiBCdXQNCj4gPiA+ID4gPiB5ZWFoLCB0aGVuIHdlIGhhdmUgdG8g
cmVseSBvbiB0aGUgcmVzdW1lIGNhbGxiYWNrIGFzIGFuIGluZGljYXRpb24gdGhhdA0KPiA+ID4g
PiA+IGxpbmsgaXMgdHJhbnNpdGlvbmVkIHRvIE9OIHN0YXRlLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gQlIsDQo+ID4gPiA+IFRoaW5o
