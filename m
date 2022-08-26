Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49FB5A2F99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbiHZTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344377AbiHZTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:05:28 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55D24968;
        Fri, 26 Aug 2022 12:05:26 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QG5njn011700;
        Fri, 26 Aug 2022 12:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=z5HECKoCjKL5yx/n9q7esyuCSGThbcXDoWZHACEUqd4=;
 b=QTG5xARv7xvAaWlBLQ9Ls4FLQqJrBtgHVfL0LKannCFGYUizhlGsMrow5Sz+SAj3thOs
 O1JD7jQZqEUjNkkOTIQgnUGxiGg1vuw/WmGEFZPCFJsU/gDlXi/nAJ9mSqp7u/rUARZm
 c9vyAkn8ZWgHUWrI5c/4blZ4QeQ4kG/w9swsRrDmfrVRF3Cn2AFYaF7Ty00rrBvJhcxN
 BNjtheAhllrG/wbcXmnumpnwx+jbamuVf267M+/ossrhvq7lONltz2Fmb84iaU1oDPY1
 Q4aMc4O2rDxrkFBA6Kl9KNhokUEXresnoFwWl/NOWZJYYQY/j2mbQVBRfPA6Q9Utymil Ug== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3j5abruk22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:05:20 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5D7AE40083;
        Fri, 26 Aug 2022 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661540719; bh=z5HECKoCjKL5yx/n9q7esyuCSGThbcXDoWZHACEUqd4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HSPlGroBTwiW3z8C3TV6K9koMZFWVSAV7QBcos+UMrX/L8yQyThggOoqyFuCvUw5x
         BqpTpFDLqgKGeCxOJvIXVZtgG1p0VLw/uA8oiR2RfcvUZ1wfLYeE0aERwPylGRIQhw
         SMHJnHPnGZbg2hvYoxwSok6VKl7t7LDjqcwtYaOEnxzfl7MfvnBrUjf5CR78Bz8bor
         xUTj4iaNyWy+l0IX6PwdQsc336aHqwYt3wm/mKYc1ZSPoGkG53OtLcqdbfA7qCVKGi
         UNnGEIdJOU4H5FAzkU36x6FHnaYesAt+2k1C2AQIJ32ugIeHafIf6ZRJAFOKAwu/+X
         aqlwO4SPUbYTQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3D167A0099;
        Fri, 26 Aug 2022 19:05:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A916740073;
        Fri, 26 Aug 2022 19:05:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dnJSI7+0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6HtPekydnIQg5bh5+uT5I/ccRH6DSEhuSPWhx/0UKNoVpKPflVjbvWLAXr8cmMxe1XnyYtCvDh1uSdBXHIQp0WOJS9bYrSQmXZOfE43w3EL8Entr8GcXmNYMiFhTSxpHH7kHl16Jvhssn16j3vUrXaUQnrK06QW9J3iyVA6k5ckCxiACKkQ4zYk1uiU/0hBlwjIBCs7YlptUnXdHJeNSSJOUa+Ct3rn2olN+F8FTuwppUjqXl/td7XEU2/zr161upaQxlEVm+15UIxFUNgEL5D1xXj4y5y3odLZd4gyUwfFJDFIrRKJLjI+2Y4WV/gdrVitRaRXMz7ZjM/QOagI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5HECKoCjKL5yx/n9q7esyuCSGThbcXDoWZHACEUqd4=;
 b=E4DybkO1bUtWM9gvxyoCy5SQqAdiGMCT1jzZ5d18HqwDYYOG/rYhJfhFSh1ljolQ/Pe/+FH8cBK7iaE4XRWAkTcBFvaS7FggYvbuPqi5f5iEsaTw6M3abBT90Wu4Mmx6zeGeE0KLcdUn0NdLNhE0vMSyAsdBwhGDVYlOhbCU1qYANkKbAJ4dvoH2b2XR6sw4Q497+dgfXOwcY+Pgk2gyin6WhgKu6mJA++k5WzgcgBOAUhbSTj1cdvulX/c44DccBW13OBz2NNs13PzkYPRIZK8OMExRPujUOpn/otVfvpubXOHat7jqnnWi/qzLOpMQ7NsuNg4rHSGlCE0O6YdAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5HECKoCjKL5yx/n9q7esyuCSGThbcXDoWZHACEUqd4=;
 b=dnJSI7+0pGU/b93Bc0vve0CmidTh27Ox54616V3TmEmD4dir7yT0RcQzlZ7r/qeuYkCaYkXVmFM7IVOztNVuHH6uj+1loDkobfvwNZeoUSNRGFE8qoYzwbqKitFcQHUjJ5ya5fBgQ0Sj4g1pKpCGWS5XDId5cu+AXuRI2r7Vi/4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:05:15 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:05:15 +0000
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
Subject: Re: [PATCH v2 21/25] usb: gadget: f_tcm: Get stream by tag
Thread-Topic: [PATCH v2 21/25] usb: gadget: f_tcm: Get stream by tag
Thread-Index: AQHYmw7V2jJiHUOYcUGbHzJbzEDB/63BICcAgACnQQA=
Date:   Fri, 26 Aug 2022 19:05:15 +0000
Message-ID: <20220826190510.shc3ppagj76iwmfz@synopsys.com>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <3fbae6ecb8e9f31807635152a377b076e86fb12e.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwiNGK3ZZeYi2lN7@linutronix.de>
In-Reply-To: <YwiNGK3ZZeYi2lN7@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f35473-be9e-4ea8-fb11-08da8795e90d
x-ms-traffictypediagnostic: BN9PR12MB5100:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kgl6crekyYky6WE+czc97jFfruFE+zR3cgzSpFi25DATwOkRMx/KOom+GHiDSJXQCmaZzUtl7BocGIL4iNfEXLFE3qp9ZZHYWbbat8B7IW9Mvic31rqkAmebu9ZAtp00TofmKTBuW+PIcEq20z3gG0nE/NS4ZqTvewvuyNAWQNStZY5Zkx82AA+8RZ7eSme4B17sJBjvIV2xUGtDkj5qlc+N3wso7mNqcmf+ip9vldBBfFJ+RlJoSeUat7yPjCxIA10yjL9U3B+hCM8ppat2qRtfZlrBx5U8wuY9Jzd1JkUYjib0vmKx3VB+YjaMIX6cVhz6rlYd/6zAjVojtz4xJQ+mFGixHhQ11ky0+rK4IWzZfeCNtUomeNWO5bZttYRZhA2TbIelbkCRalFWTNSelu8XuTa11snK+oM9ESThak4D9YruGTrfdStpEVleL3GfNwqDyegTmQA7Hpc5k9aE7XnAZB7xu42+Kn2fDM2YsdV6gS6ptdfXAbTiPfZI0Kve+tv7REf4V4QHqfdJPcNXSxzW/V05fwodXv219qh1eJl1u0r9PPWmnfqimmuybfcFCISlD/1xDqJzZ5BIIb8jC37oRWub6O3a4/G/lFEw0U3UFg/Uz7AqGV0DvfnetUcqfkAsbQBSLYY6aVwgKjV9BcWPshhwrmYdoj0L4vleglFJdyQC6gGRCPfvB79NiMX3kEfGIIFkxjm3DzGUQ5urXoG97bsJ7i++Q62RXZfdlu7ZNQVJ6z/I7xpN1cCFIlcBNzC9DJLTngMO2JcgkAfpnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(83380400001)(1076003)(186003)(2616005)(66446008)(38070700005)(66556008)(66946007)(54906003)(64756008)(316002)(36756003)(71200400001)(76116006)(6486002)(4326008)(6916009)(8676002)(66476007)(53546011)(5660300002)(26005)(41300700001)(2906002)(478600001)(6506007)(8936002)(122000001)(6512007)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmV5d0J3ejB2VkJXdmhDU0JzTjBEdWZMNWdNbHQ4QVd4Z1ByejBCT1ZVSmoy?=
 =?utf-8?B?QU1CejlPaFo3THRjTGZrUzl6aDZqZG9DNlFnWlQ1Nk9PTWtzZCtaNFRPTlVV?=
 =?utf-8?B?a0IyZ0JBUCtuRWhHQVhoODhseDEyWUhHL0VYeGk5QlQ0TFVVV3BRTEhzaSsz?=
 =?utf-8?B?WEpQQnE4NlVXdnpYdmtlanRycThROVlFOE9xWXVIcTljZVh3bDR4RlgzbExG?=
 =?utf-8?B?YnJZd2lpcDZuUVYvdTZQNnUwV1BsWW1JanBTNDlwZXFLNUtLSUFiNjVlN1M2?=
 =?utf-8?B?bkVJSjRSV1YyZHlJcm1oR29sUGlrTGVFOWxFVFZNdmc1aWhZdE5QbmZwdkJ1?=
 =?utf-8?B?N0o5aS9FYUJCWkVGZGJhWmVqZzFJaVVpT09FeWE1cVBvemh4YVpoQ2txVjQ1?=
 =?utf-8?B?ZFNyODJGWmNYUzV4VFFoZVNlMGRJam1LT2dFVXVHQ013T3llSU84YSszU2Js?=
 =?utf-8?B?ci81VmhWVld5OUJzeXh6YTF5b3hrK3BGc2NxanA4UFFBL3BOQjBNTTdyRFlx?=
 =?utf-8?B?MHRDYVFGQVExcXJ2UHRGc3ZYQWtDUXhtZys5KzJUWDhpRG8vMXFhOG01dEc1?=
 =?utf-8?B?dW1CNzdOM1FjMG5xcU45R1dLZW5yUUNhaWxWcUtMYlRxWXg3NTFUNnNmb0VI?=
 =?utf-8?B?Q2JWTzJJeWVtQVVCZENKa0tYSEpVT0VFSGlkbXVBY2pPRlVWelJERnBhZi9E?=
 =?utf-8?B?UG0xcDBwRGRFbXhmNnU5TkNUVVRHMzd3U0tURWZjSGdNQlYyR3NRRTIyYVdJ?=
 =?utf-8?B?Ykhqa1R4TklYMXVQdzRRNE9xa3p2UGNRMjdRaWhYODhqcGZlNWpHZzhobkRE?=
 =?utf-8?B?M1d5RlBiREcyd1J0RnN1WXdnWHJ0WEttNkpJMHdoY1BGbFdsMnBPcDFNSS9n?=
 =?utf-8?B?TjNJQ3E4Q1dJT1VxNlF5cHM2d3BHWW1iejRLUTBUc2d2REIrNStuNjhKbWdQ?=
 =?utf-8?B?Vlo4L0oxb3FRS0dGaXF5aW1HQzVXU2JHaGdkTkVsVStwVHhJWTVobkY3MmNq?=
 =?utf-8?B?a0RDTGhZd0RPWW9DSUlRWnFMZ3JjM09Hd2pBREIvcHJqRFBxYUdGbEQvUXVY?=
 =?utf-8?B?YlhBVC9xc2RLNGQwWkN2cjBSZ1BTSjlaQWdYakhUM1BPLzFONkdGT1dHN1pm?=
 =?utf-8?B?M2NRVVNWa0JsaTZ6VjBZcjBUb1c1WkJXOHQ0bHdHeGFrdm1LaDF0R2h2ZGZU?=
 =?utf-8?B?V0VZdGtBUyt3RHBERTU0dXdWUG5kM01zS2ZiMlpWeDJ1dFU1YXJPUEJ1S3pl?=
 =?utf-8?B?UlFNNlRieW5YUG5oT2huYnlLVzREdmNxNWRXTFhWMndVSCtPMDlPck93VjIy?=
 =?utf-8?B?OUVyeDRqY3BHV3V0am5tei9ZMk1MSVFjbVRvQ08zM0VXeGwyWVZuUXJVQ2VE?=
 =?utf-8?B?bnZEdnhwbCtYQ0pvZFpnZTZsMHQzSzM4OHdpR2sySkVHOWNZWS9TVjFlN0xu?=
 =?utf-8?B?OG5pdGNEWFhQekJVOWo0Q01SUkV4UWcwV20yeGZRZ1h4US9vc1ZqNE82LzVH?=
 =?utf-8?B?RW5jamJJd1BtZEtLaDRsbkYvVFdZT1RlWURvc2g0SjJqMXdzbHB6QVFJVjFl?=
 =?utf-8?B?NkJzSnJUcU95cXRSOTRYUTY5cUhjR29UdlJCaU16YVJTNGJTaTdkM0VUVDIz?=
 =?utf-8?B?YlZDckx3cGZXV1VBM0lmZUphOSt1ZitVaHMzZ2tGdkVBM0hpN0RqZXp3a0Ft?=
 =?utf-8?B?aHdOR09xMlFQd3loWmtEYThsTUFDR0hOc3NzTVI3TTU2Y2tYSlhVeEVVN25t?=
 =?utf-8?B?MDJYazJIajF1TWpSZWZLNnRvT0ZjL3J5cDJ5RzVhOGRwYkUvampUWFdPNmJa?=
 =?utf-8?B?SnFpb1kvbUJ6TDdlak1QTk5nZ3c4TTVlUitzaDlHYUxzeTR1T3BOWVh3V01B?=
 =?utf-8?B?MU1aWWZxSlhWaktpS0trWFZ3UXA4SFBkMzhreUdnL3JlUlRaUjhnWkJaWldi?=
 =?utf-8?B?N1V2MHgybFNLSllFSEY4RTJvbkZQZ0tqTENLajFnQmVSb1J0Q2d1YkRxSUxp?=
 =?utf-8?B?UjN5cHRGT3pLWk04RE1UVzd2RWl4aDRTdzFSZ3NSTUk0b1A0N0tDMm53MVI5?=
 =?utf-8?B?ZHh0SFRqMHVFbnRFaFRxL2ZKMFJLY0NXZXIwb25LZEQ1U0RPcHZsdi8yQkt1?=
 =?utf-8?Q?A9E0l5X22jnGXB7y1S1sZhseC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D337838B84365A44BD39F38D963006A0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f35473-be9e-4ea8-fb11-08da8795e90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:05:15.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYwwNdjq+bWWFbHdZqKilZ0Yu509u2qixaPnP5WG0+ZkdIL8Y5XkzO4HgBrgd48LWZXVHDtJApxGD8eB6EMnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Proofpoint-GUID: L-pgwsaF108PzoNJH08AXAYQ1ADn3UHE
X-Proofpoint-ORIG-GUID: L-pgwsaF108PzoNJH08AXAYQ1ADn3UHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=868 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjYsIDIwMjIsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+
IE9uIDIwMjItMDctMTggMTg6Mjg6MTYgWy0wNzAwXSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5jDQo+ID4gaW5kZXggMDg0MTQzMjEzMTc2Li5h
MTBlNzQyOTA2NjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfdGNtLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0K
PiA+IEBAIC01MDYsNiArNTA2LDIyIEBAIHN0YXRpYyB2b2lkIHVhc3BfY2xlYW51cF9vbGRfYWx0
KHN0cnVjdCBmX3VhcyAqZnUpDQo+ID4gIAl1YXNwX2ZyZWVfY21kcmVxKGZ1KTsNCj4gPiAgfQ0K
PiA+ICANCj4gPiArc3RhdGljIHN0cnVjdCB1YXNfc3RyZWFtICp1YXNwX2dldF9zdHJlYW1fYnlf
dGFnKHN0cnVjdCBmX3VhcyAqZnUsIHUxNiB0YWcpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkg
KiBGb3Igc2ltcGxpY2l0eSwgd2UgdXNlIG1vZCBvcGVyYXRpb24gdG8gcXVpY2tseSBmaW5kIGFu
IGluLXByb2dyZXNzDQo+ID4gKwkgKiBtYXRjaGluZyBjb21tYW5kIHRhZyB0byBjaGVjayBmb3Ig
b3ZlcmxhcHBlZCBjb21tYW5kLiBUaGUgYXNzdW1wdGlvbg0KPiA+ICsJICogaXMgdGhhdCB0aGUg
VUFTUCBjbGFzcyBkcml2ZXIgd2lsbCBsaW1pdCB0byB1c2luZyB0YWcgaWQgZnJvbSAxIHRvDQo+
ID4gKwkgKiBVU0JHX05VTV9DTURTLiBUaGlzIGlzIGJhc2VkIG9uIG9ic2VydmF0aW9uIGZyb20g
dGhlIFdpbmRvd3MgYW5kDQo+ID4gKwkgKiBMaW51eCBVQVNQIHN0b3JhZ2UgY2xhc3MgZHJpdmVy
IGJlaGF2aW9yLiBJZiBhbiB1bnVzdWFsIFVBU1AgY2xhc3MNCj4gPiArCSAqIGRyaXZlciB1c2Vz
IGEgdGFnIGdyZWF0ZXIgdGhhbiBVU0JHX05VTV9DTURTLCB0aGVuIHRoaXMgbWV0aG9kIG1heSBu
bw0KPiA+ICsJICogbG9uZ2VyIHdvcmsgZHVlIHRvIHBvc3NpYmxlIHN0cmVhbSBpZCBjb2xsaXNp
b24uIEluIHRoYXQgY2FzZSwgd2UNCj4gPiArCSAqIG5lZWQgdG8gdXNlIGEgcHJvcGVyIGFsZ29y
aXRobSB0byBmZXRjaCB0aGUgc3RyZWFtIChvciBzaW1wbHkgd2Fsaw0KPiA+ICsJICogdGhyb3Vn
aCBhbGwgYWN0aXZlIHN0cmVhbXMgdG8gY2hlY2sgZm9yIG92ZXJsYXApLg0KPiA+ICsJICovDQo+
ID4gKwlyZXR1cm4gJmZ1LT5zdHJlYW1bdGFnICUgVVNCR19OVU1fQ01EU107DQo+IA0KPiBDb3Vs
ZCB5b3UgcGxlYXNlIGF2b2lkIHRoZSBhc3N1bXB0aW9uIHdoYXQgdGFnIGFjdHVhbGx5IGlzPw0K
PiBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgaGFzaHRhYmxlLmgsIGhhc2hfYWRkKCksIGhhc2hfZGVs
KCksDQo+IGhhc2hfZm9yX2VhY2hfcG9zc2libGVfc2FmZSgpIGlzIHByb2JhYmx5IGFsbCB5b3Ug
bmVlZC4NCj4gVGhhdCAlIGxvb2tzIGVmZmljaWVudCBidXQgZ2NjIHdpbGwgdHJ5IGFuZCByZW1v
dmUgdGhlIGRpdiBvcGVyYXRpb24NCj4gd2hpY2ggaXMgc29tZXRoaW5nIHRoZSBoYXNoIGltcGxl
bWVudGF0aW9uIChhcyBvZiBoYXNoX21pbigpKSBhdm9pZHMuIFNvDQo+IHRoZSBvbmx5IGFkZGl0
aW9uYWwgY29zdHMgaGVyZSBpcyB0aGUgYWRkaXRpb25hbCBoYXNodGFibGUgd2hpY2ggd29ydGgN
Cj4gdGhlIHByaWNlIGdpdmVuIHRoYXQgeW91IGRvbid0IGFzc3VtZSB3aGF0IHRhZyBjYW4gYmUu
DQo+IA0KDQpTdXJlLCBJIGNhbiBsb29rIGludG8gaXQuDQoNClRoYW5rcywNClRoaW5o
