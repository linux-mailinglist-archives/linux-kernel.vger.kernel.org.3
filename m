Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACA59662A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiHPXwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHPXwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:52:00 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E590829;
        Tue, 16 Aug 2022 16:51:59 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GIO7ki004515;
        Tue, 16 Aug 2022 16:51:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=VtfOaMq2jeo5CvCUeTHwfpyL5hLSXo7Jf8OBaJwm0YI=;
 b=EPPN6YOq4MOrqabU7RWuuWa4A7uOOz+zkrNqkiCCtSFxG/WnvyGhRgMhlx6BrjWgLbVS
 ADhhrNPwZ9+zR3gBvCtNWObYfIfFKppXSIiAqIG/gP9/mnizU3iuE/qPo0gU2qNbpvAI
 BY+ukdrhurHYCwesFKZOa0BpiWlxeo8qnqHE8cIo2FQBKCiuhZ4P/6kOI9+NvunCqIHt
 s4158dsIKc5OiDYq7h98zOqAFgbPcwrRRaYvAgxOj9SrZGfnsRDUoJgjUrxE4MPxxx1x
 kmt2HpC7XAjl/Mvv2Quvcb3IeOP2fWnlIheA8Wp4HD1H2Mic5ZHj6mklleyWcfvbHOTm tw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3hxakeyht8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 16:51:45 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F01B8C00F4;
        Tue, 16 Aug 2022 23:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660693904; bh=VtfOaMq2jeo5CvCUeTHwfpyL5hLSXo7Jf8OBaJwm0YI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZRX8r1uMjoTFTM9tc/lwBYcR/dQCEfRlF1vhPCsNLQa0YBtz2ftztEI7+3pycjBrs
         FMY6LZB3/okgpXEEIFG9Y5mnBHoOgJjcl/BvEOmOcyc6RiBVWbSm9R2gi4Ihoqkzqp
         8gYary6nILa00prfHS6ni/DYj8cGFFXSuCIDKUDjgvPODC7l3vdyRf1EdYVNLYn5Jz
         XnJPAqE28pi8TrK3T6wh4Cmnr6n/V9ePbsH6CuZhctz6pLBZQ+0+8BDrmXKI7u6+ZI
         z1TNobh5aGh1NT7B3GMhLPnhFC0+crP8Sd18Hy2NlegSoZ0fUBj9GXlrwSCDNUe/t7
         tFysTOAeJZWhw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EBCA5A0082;
        Tue, 16 Aug 2022 23:51:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 52C5180199;
        Tue, 16 Aug 2022 23:51:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Rule+MPe";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJrWiXyeRZoVL/Ro9fr5j2Ob9Hkbsdhmn9KhsHBR5SGT2Il4nMMjOWxcsiU2ROOKewSQYloHJCd8pVBowhtfSGKu/KlO5QJ8SHlG/WAFd+r1FADWOvnj8PIiCyevzHnyl0R/1Swu7WeLQ+8It21sO+d29NgOkWIzGRn9/sqsxy+lGfLu2EK8RKtFc+T7Wau9LXpurgW5x9MIeH7PbA0uxwpqMC64iC4fQNfElTsOwdu9FQgrf5hNdJXwogxvcJm4nlkko8ZeKQHwS/l1xNMlgamQXrVYfhZUD1Q0q7qqrC1OzjiFkC4upPI4Tffe379qG6G3rkreTefoxpAa/D7F3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtfOaMq2jeo5CvCUeTHwfpyL5hLSXo7Jf8OBaJwm0YI=;
 b=R2HCpZ6ubSWG2G4NNt60l+g8HaWxBuBitUda484gT3TYZgIe/KsKND8UyFfLTkBeklxHRQ2NKPHvO4smpoXgJnF0fXLFL3eHgeYGgnhJVwcTQ7RgngtgsKfTTsvD9LH+OTTjWODjVLhsLy5qfGq2gSeXPrYpgk7OE9gSFWy+eUhvMiu2uwqC0G7rvHaZtyTcf8BCdQATTR78pEzOagJxnjP1tsSSInsERgli2eUaASdZITrxa0Wy8zSuX1DzWR7/+b/HvvkBfnKhyHBXemjFmDstPjpH4G/6NauEdiKNlMNAHYeeJI6ans7xwZgiCtEsbCOsZgiE2GhxwZcirxMU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtfOaMq2jeo5CvCUeTHwfpyL5hLSXo7Jf8OBaJwm0YI=;
 b=Rule+MPelBeTslEKxhvst6U+slkMivol9x2vWul3Ox1yJM9kIZUpAlJ9FekVbH/b7px069sLJQXSbKzCAhiRaEE0pcUxBUDPNRbFADklJ5TK18x7VNlS+9U4Rzd0V0dae/rB4Z0beKGKraSRQPCr+KBimmIuHnti51Eoxwe9sDY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3254.namprd12.prod.outlook.com (2603:10b6:a03:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 23:51:36 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 23:51:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4CAAXhZgIAF+LQAgABBaYA=
Date:   Tue, 16 Aug 2022 23:51:36 +0000
Message-ID: <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
References: <1659467920-9095-1-git-send-email-quic_eserrao@quicinc.com>
 <1659467920-9095-3-git-send-email-quic_eserrao@quicinc.com>
 <049219f1-8c68-e4cc-7bf9-1e8c214e80aa@synopsys.com>
 <32a0765e-00d9-1a67-bf36-4060c5fcb008@quicinc.com>
 <8705d52e-2181-aebd-43b8-2c8d021339c7@synopsys.com>
 <5ad70f41-622e-2d75-7c53-89aba1255a5f@quicinc.com>
 <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
In-Reply-To: <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4314f9e4-9c5a-4e0e-0fe7-08da7fe24170
x-ms-traffictypediagnostic: BYAPR12MB3254:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxuRFnAyOeTyN+90RHsOiegm0T0oA7LKKViuzpVUL1ThaOwxLxSxqSED0PXUY2oRqCwQ5YfoZoN24PLNW17i4EAx5XyOPLHuiYJi12jZoSK8rCN27Tx7hB79RJ/Ryd15n44ZWz70owHuPZ91c8X61E72vZlV1IlSgKRARoOl+WfT2uEhiF5z5GZNSy1HzaaY+D7yuqsHOVebLn6dB9btbJ37b1v9pCWbLgjHmoujqCLdQ3b87AXd+R3gc/Q/Kz9LQNbpRrESb1WFoqeGfHysI6QfnZOCm4THE2Tggtqi6w571QpSHcY7PExGCwpTzyiXd0dtiwhCwHshIqNe2d+XyymaI4ajTb5z2qbzMQyM26IX88qMqxMujnEe8t4zXTJPwzhZTYNQMai9N2RZcbf3iWyEelYKRbG5zTNgaZZSLuqgn2viT6+e5+XOshTq7UETm89VixI/VjMhfN4hfNTCf3UZEwhdXCaHyD6hjHNXIRueeZYeXri/BCGbQRnAEVGmDns/O396S5Ju9YLl3l5w30ceIUh/pIxOZ6z6TUKyhLwl5jeEo56Ym8ZbJCM/1X7lI7zuA0q+4wK2+UW402v6q4WAQnY1+IcXxgCagmo2pPGvIi6pQOC0mH+vObj7oLJtSLcymVsKiriKCjaCNgrwoXVIZt4XJSO0TnDB252Ba57bZAp6U/ZqFtk6ogsL6N2Z7r3Aj1xQw5m4zYh4yuZh1RhuPvPqoM85cXlOTCQAF+YdfNnVWl5qmZwrGahqZefUUfuRlSSDL0IdBsEsDZp3pUtAMbULQ4TakwG7aWFBSqIKaC2huOqriGPiIrAY8ovUKclR3SFaIwtYxhXuBUirLge/OPi6vKS34VlvnWFVnxwqQnzrxxWLBOfekxmMFaXm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(136003)(346002)(83380400001)(186003)(2616005)(6486002)(71200400001)(478600001)(38100700002)(316002)(41300700001)(66556008)(5660300002)(38070700005)(54906003)(76116006)(2906002)(66446008)(8936002)(66946007)(122000001)(26005)(31686004)(31696002)(64756008)(110136005)(6512007)(8676002)(66476007)(4326008)(36756003)(53546011)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aCtNNkRobkFwRm1XTTN0RmgwNjF3eVpPK2ZKeXdzY3VCbVJBTEtGbGw2cmZM?=
 =?utf-8?B?ZTQ2ejhPMDBEcC90OVBHQmNNV1d3OC9NR1l5cVF3UHNnYmwwMUpiMURVbWJL?=
 =?utf-8?B?czYrTld4QnZ6TXB6SVNFNUZSZU4wdFhFRjNDZlFVdUVkSjNFZFRxVG52N0VU?=
 =?utf-8?B?Rjh3ZCtNQjZJZlNSeWtIQkRqSVlwVWhLeDJpTjJ6clhlb0NQUUs1cTZFRjcy?=
 =?utf-8?B?djJoUzJ3cEd1VjJMSmxJemNCcVEwVDh2OTd2cTlLbkk1OTNyVFRXR3B6eU4z?=
 =?utf-8?B?RlluVXRyK3VWcE40NWxaNlpYdFZWNDNwS2s0WmhaQ3VhckNzNlU3aFdlNjlV?=
 =?utf-8?B?K1N1M0JmL2FkVGdsN3RxRHpHWkRDN2ptMCtKSWduYkwvQ2dTSlkwcXRnakdG?=
 =?utf-8?B?dW1uL0Y1ZUN4WCtrVUphWmw5VFp2dktGZDJhck9JcmY0K1J1eEJNM0QySEdU?=
 =?utf-8?B?Y3NCUU1SNGZabFVPb1NhdXhDNWdxRTM1OUdFR2xNaFlMWVJibkZVeDFrSHZq?=
 =?utf-8?B?RjRaMkoxQXVGNkY2WEw0ZEwrZE9JNG5rWUd6blIrWVI1bXJnKzFMcDM4K2NZ?=
 =?utf-8?B?aDYyMGZvQU5FTndtUTlnZEpacHcrbGFEaHA3RWhEMUtXVkpPQnIrSUNuejht?=
 =?utf-8?B?NS8wR1gwQmVhZ2U5SDlib0E3UUlTcnVCNWRpem9id094eW5uUjl4aExRWloz?=
 =?utf-8?B?aFVJQTlyd0hCVERFNHpZd0lFNEpYSDFuZE9OSUlGZHRkbnRhR28rdWF6ZytB?=
 =?utf-8?B?dWZKUm5lNVZXbW9oOUZjZVhRcGdaZ0c2VjZLd0JsYmhDVG1JS01GQ0RiQzJH?=
 =?utf-8?B?MDB6ZkhqS0hRN1UzcTM0bllmQVRLTHZabVRUdElqNEs2UXBQekk4TGllRTRG?=
 =?utf-8?B?ODVzQS8rUnhLQmlMcE1jV3VQc0E2S29TSlFkZWUzRGtETmpnMGY5V0phdito?=
 =?utf-8?B?VW9HTW9EVnlJRkdhSHpJREhnamdhOUZoVis5Y29OZUsrOXNXTWo3azVUaTNF?=
 =?utf-8?B?RmhkMjNHQUZGcHFoWFg1eGJ2UGhiaHp5MllBUHlDZHdxVEh0OFNOZGNrbmo2?=
 =?utf-8?B?N3UxTmh0TDhGczMxQVlVazRMS1pZYUJFRUEvQjBTeWp1SllYOWlwWDJmczNZ?=
 =?utf-8?B?R0NzbWJoOGhPam9FWFZxWFU2R3oxcXZyTTVsVEltWEJIZ3A5YzlxS29NMGxL?=
 =?utf-8?B?M3ZsRnQ1Y2VaZkFOM3NiNHdEL0hpejI5R09vSXYzZWlXRmlGai90V3hLSnJQ?=
 =?utf-8?B?MU9qMVdlZ1NySVlVL3lULzBMVk9zUGRLRExtUDl1TVozR09JclBlaFQyc21W?=
 =?utf-8?B?RGN0anZCU0xLck9mcmE4VmM2Vjl2aHVQSDBkTjgxRHIzL3ZEd0U5cmVkK0cw?=
 =?utf-8?B?bDJSTzFzTXlGa3NzSTRXR0YrdGhPTGlWcTB5YkFnNXFBc1V0bFk3WVBtQ2Zv?=
 =?utf-8?B?THhCVnh0U01QeWh6U3RhWjRkMjd2cmhaSmZZcmRpdHRZcGVvU0FzV1NGaWFX?=
 =?utf-8?B?VmlFd1BBVW9qSDl6WGw4R1EzSElRSGFNYUMvejNmUW0zeEZKNWhVck5sYzBG?=
 =?utf-8?B?RGRwZmdnSUx1NU1uNDBhU2NGa2sxRlV6RGhDei9XdVZUNzNrWm5pbFFrb2g0?=
 =?utf-8?B?U3NVbmhlMVoxMWNLdUhlRUdYSEFZbWU4Z05aMEtBd3pzV2lod1dlc1lMblY0?=
 =?utf-8?B?TkthUU1TRWlZOEkxcDBKU243T0dPcG9oSlBHdUZnUXpZeC9tWmIrMWRYaHVG?=
 =?utf-8?B?M0h0bFkyWENCWjRqdDdoTHNOdXJlUW5qWjhrcSszSUtBOWswVnA3eHFEb3px?=
 =?utf-8?B?Y0UrSS9CVW5pWk9naWhOMTk5M2hwTDFpWDE0QjM5Vm95QWIveDZEcC90VDhX?=
 =?utf-8?B?RTcrZVNRVlUyU0ppVk9aMW5KQU83STZTYWVDNjBIY1E1WmZxR1RLYzErZjFl?=
 =?utf-8?B?TFdyUUlkb2pvMHhkQ3V6L3c0WnhXZm0wc091MzE4SEMrWTNTdkZYQWd1VUhN?=
 =?utf-8?B?dHV5czc5ZlJCS0xGSHJ1V1Zna2FOR0dFeGRoK0c4U2V2cWlwSUFOZ3p1aXBV?=
 =?utf-8?B?R1BXNi96TlUwYmdTeXl4clQrM3U2bG1IWUl5WW1obE9ZQ0lWYitRQ3d3REs3?=
 =?utf-8?Q?misc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1839F2594E636147A5F2CDE7768E806D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K0dJK1RMTVphUllvWUM0bDVOcDBrV0xTMHJDQWlQc2RpVmhBQUxzV1ZjS2pF?=
 =?utf-8?B?L0FGVXNzUGFqODJaamVzWFNQZzBwWGpscld3bnIvVk1pN1FpTUdEL1NTTC8z?=
 =?utf-8?B?YzV2WlVhUzJWa0RKMk9QaUJKTW9oQlZ3MEJsVGVWYTBSekNqVVpUc0VOalVJ?=
 =?utf-8?B?d1lhU0JGTVA0RGxaRERWLzJCRTlxVDlrSkxQWDhiWDdPQVplNEtBb2JCRE1r?=
 =?utf-8?B?ZkJ2dTNSaUUyZElWYWVDSUxIR2VDeGJBV2V1NnNpdDJLUGp5ZG5OOUthcCsx?=
 =?utf-8?B?akUreFV4WS84NlpDZEc1TXNOaVhwQlFlbjcrMkN5czI5YXdKWjFraTZVeWxS?=
 =?utf-8?B?bU44L1g1U0YyMUtrV0RHZ2pONWxOOHlma25TVFhLaXBBaUlkZ1I5VHNuZ1VI?=
 =?utf-8?B?eVFobU5Ub2ZiYWJmZWkxeEtUY0tLR1pCK3pBSGYvN05Zb0RRTElUa0MyQzR2?=
 =?utf-8?B?WTdpMG5iWkQyb0pyK3c3eUxSK24yYlZOMUxId3pIcEJ4cVY3WElxVmNrYjhG?=
 =?utf-8?B?RnIvS2dhSEhnUXVMOWNMa214Q3N5WWczejF3d1dyYXdiRi9jUjlXc0Y0OHps?=
 =?utf-8?B?RlIyVlJURmx6STRlV2RJWFdzZTkrOUFvSUV1TGFGdjlRbFNVVjZramlkZEYv?=
 =?utf-8?B?RW9OakFjeEk2NGEzTi9ZWkNETXhqOWpOV1FYemJsMkVDOGZBOHBZK1NCa0dW?=
 =?utf-8?B?SkFGOWJDTW5qeDZEQXdQL1BmZ0ZlTGp3WENHL2RTRjIzbXRJcWQ0MHRhc2NE?=
 =?utf-8?B?bnQ3eDJnODAzUVN5OGR3UnptaVVzN0p6T2hTYU5BdW5OVVh1bGMzcXhGWjhM?=
 =?utf-8?B?R3lBWi9kZzB4MDI4OU0xOWx4c1Q2SDFXZ1dvdk1TN3lwdVZaUDVSc0xyeVJ5?=
 =?utf-8?B?K0dXbDVxakhtMVQzbzI4Y21hanlmNXhycVVSYUlLOWRuMENGaXhmMVJRbkZC?=
 =?utf-8?B?dVF6OW5KS2J0MnYxdHVFRUhwOGRGaUNHMHl4dDFHZkU5b2ltdHpLQXRZWVI1?=
 =?utf-8?B?ejVCNTNhYXRRK0RkZlVnYUZNSC9RcFNhNWx1cGlSaEQzeEVYTEpqTUs1ajN2?=
 =?utf-8?B?ZkxRU1hrYWpYOXV6Sk85WllNOU9uYXA2YldJdkpjb0VwSm9pOEMwVDAxeUF1?=
 =?utf-8?B?bGtENDBLbUt4SFM4VlpWM2RRcW1ad09LR1NqT2V1UEc1N282MVZweStBUzJG?=
 =?utf-8?B?NG80T1lBTWdEQUExRGl0Q3pWTkJFZHRZWUxLa1J6N3owbkdnR1FWcXhhYitD?=
 =?utf-8?B?d2wvbmZJZTZNeW80dHdPdUs2aDNUa2ZvcmZBVnlhWjVnL2dzWUg5YVF6c2h6?=
 =?utf-8?B?dlpad0FxYlc1cDRwaVUydzZRN2RBNmM5Y0pMYUw4ZnZOcVE1bTZPSzA1bVIv?=
 =?utf-8?B?YUxpT2NLeWN1aDg5YTBtdUpsbHhhQzJRZzNFMjZJZHJaNVlNbHFnZ2htYnQy?=
 =?utf-8?B?TWR6eVp3eFBKUWgvUmZ3SFBRRkRIcUxydDd6QUpLN25TZUxSYzRZeFluSEls?=
 =?utf-8?B?WFRVbjJFdUszVDlQOVBWZXZwcU5tZmswOEx2R0Y3OEFXSmM4YVdLZlNWVnlR?=
 =?utf-8?B?eG1WS05LSGtQRGFnTGt1R1VnMDh3dDdGTzhQMmtPVTJ5b3Z2dTN1eU01eVVF?=
 =?utf-8?B?NXJCUnRvamw3MGltYS9Jdk4zWU1VM1E9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4314f9e4-9c5a-4e0e-0fe7-08da7fe24170
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 23:51:36.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpAzPGbJ2Vu6qvkFZN99EUwCF4RpJ/7GMgFZvkndvUf1DErrvncVXbtTiIyRTrJjOBMk63WNMpqqO+fyiKik6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3254
X-Proofpoint-GUID: RzV84ThvxOgQOFmdZvgt2MAjZpbGC0vI
X-Proofpoint-ORIG-GUID: RzV84ThvxOgQOFmdZvgt2MAjZpbGC0vI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208160085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNi8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+IA0KPiANCj4gT24gOC8xMi8yMDIy
IDU6NDYgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IE9uIDgvMTEvMjAyMiwgVGhpbmggTmd1
eWVuIHdyb3RlOg0KPj4+IE9uIDgvMTEvMjAyMiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBP
biA4LzExLzIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24g
OC85LzIwMjIgNjowOCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+Pg0KPj4+PiA8c25pcD4N
Cj4+Pj4NCj4+Pj4NCj4+Pj4+PiBUbyBzdW1tYXJpemUgdGhlIHBvaW50czoNCj4+Pj4+Pg0KPj4+
Pj4+IDEpIFRoZSBob3N0IG9ubHkgYXJtcyBmdW5jdGlvbiByZW1vdGUgd2FrZXVwIGlmIHRoZSBk
ZXZpY2UgaXMNCj4+Pj4+PiBjYXBhYmxlIG9mDQo+Pj4+Pj4gcmVtb3RlIHdha2V1cCAoY2hlY2sg
VVNCX0NPTkZJR19BVFRfV0FLRVVQIGluIGJtQXR0cmlidXRlcyBhbmQNCj4+Pj4+PiBoYXJkd2Fy
ZQ0KPj4+Pj4+IGNhcGFiaWxpdHkpDQo+Pj4+Pj4NCj4+Pj4+PiAyKSBJZiB0aGUgZGV2aWNlIGlz
IGluIHN1c3BlbmQsIHRoZSBkZXZpY2UgY2FuIGRvIHJlbW90ZSB3YWtldXANCj4+Pj4+PiAodGhy
b3VnaA0KPj4+Pj4+IExGUFMgaGFuZHNoYWtlKSBpZiB0aGUgZnVuY3Rpb24gaXMgYXJtZWQgZm9y
IHJlbW90ZSB3YWtldXAgKHRocm91Z2gNCj4+Pj4+PiBTRVRfRkVBVFVSRShGVU5DX1NVU1BFTkQp
KS4NCj4+Pj4+Pg0KPj4+Pj4+IDMpIElmIHRoZSBsaW5rIHRyYW5zaXRpb25zIHRvIFUwIGFmdGVy
IHRoZSBkZXZpY2UgdHJpZ2dlcmluZyBhIHJlbW90ZQ0KPj4+Pj4+IHdha2V1cCwgdGhlIGRldmlj
ZSB3aWxsIGFsc28gc2VuZCBkZXZpY2Ugbm90aWZpY2F0aW9uIGZ1bmN0aW9uDQo+Pj4+Pj4gd2Fr
ZSBmb3INCj4+Pj4+PiBhbGwgdGhlIGludGVyZmFjZXMgYXJtZWQgd2l0aCByZW1vdGUgd2FrZXVw
Lg0KPj4+Pj4+DQo+Pj4+Pj4gNCkgSWYgdGhlIGRldmljZSBpcyBub3QgaW4gc3VzcGVuZCwgdGhl
IGRldmljZSBjYW4gc2VuZCBkZXZpY2UNCj4+Pj4+PiBub3RpZmljYXRpb24gZnVuY3Rpb24gd2Fr
ZSBpZiBpdCdzIGluIFUwLg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBOb3csIHJlbW90ZSB3YWtl
dXAgYW5kIGZ1bmN0aW9uIHdha2UgZGV2aWNlIG5vdGlmaWNhdGlvbiBhcmUgMg0KPj4+Pj4+IHNl
cGFyYXRlDQo+Pj4+Pj4gb3BlcmF0aW9ucy4gV2UgaGF2ZSB0aGUgdXNiX2dhZGdldF9vcHMtPndh
a2V1cCgpIGZvciByZW1vdGUgd2FrZXVwLiBJDQo+Pj4+Pj4gc3VnZ2VzdGVkIHRvIG1heWJlIGFk
ZA0KPj4+Pj4+IHVzYl9nYWRnZXRfb3BzLT5zZW5kX3dha2V1cF9ub3RpZmljYXRpb24oZ2FkZ2V0
LA0KPj4+Pj4+IGludGZfaWQpIGZvciB0aGUgZGV2aWNlIG5vdGlmaWNhdGlvbi4gV2hhdCB5b3Ug
ZGlkIHdhcyBjb21iaW5pbmcgYm90aA0KPj4+Pj4+IG9wZXJhdGlvbnMgaW4gdXNiX2dhZGdldF9v
cHMtPmZ1bmNfd2FrZXVwKCkuIFRoYXQgbWF5IG9ubHkgd29yayBmb3INCj4+Pj4+PiBwb2ludCA0
KSAoYXNzdW1pbmcgeW91IGZpeCB0aGUgVTAgY2hlY2spLCBidXQgbm90IHBvaW50IDMpLg0KPj4+
Pj4NCj4+Pj4+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayBhbmQgc3VtbWFyeS4gSSB3aWxs
IHJlbmFtZSBmdW5jX3dha2V1cCB0bw0KPj4+Pj4gc2VuZF93YWtldXBfbm90aWZpY2F0aW9uIHRv
IGJldHRlciBhbGlnbiB3aXRoIHRoZSBhcHByb2FjaC4gVGhlDQo+Pj4+PiByZWFzb24gSQ0KPj4+
Pj4gaGF2ZSBjb21iaW5lZCByZW1vdGVfd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtlIG5vdGlmaWNh
dGlvbiBpbg0KPj4+Pj4gdXNiX2dhZGdldF9vcHMtPmZ1bmNfd2FrZXVwKCkgaXMgYmVjYXVzZSBz
aW5jZSB0aGUgaW1wbGVtZW50YXRpb24NCj4+Pj4+IGlzIGF0DQo+Pj4+PiBmdW5jdGlvbi9jb21w
b3NpdGUgbGV2ZWwgaXQgaGFzIG5vIGtub3dsZWRnZSBvbiB0aGUgbGluayBzdGF0ZS4gU28gSQ0K
Pj4+Pj4gaGF2ZSBkZWxlZ2F0ZWQgdGhhdCB0YXNrIHRvIGNvbnRyb2xsZXIgZHJpdmVyIHRvIGhh
bmRsZSB0aGUNCj4+Pj4+IG5vdGlmaWNhdGlvbg0KPj4+Pj4gYWNjb3JkaW5nbHkuIFRoYXQgaXMg
ZG8gYSBMRlBTIGhhbmRzaGFrZSBmaXJzdCBpZiB0aGUgZGV2aWNlIGlzDQo+Pj4+PiBzdXNwZW5k
ZWQgYW5kIHRoZW4gc2VuZCBub3RpZmljYXRpb24gKGV4cGxhaW5lZCBiZWxvdykuIEJ1dCB3ZSBj
YW4NCj4+Pj4+IGRlZmluaXRlbHkgc2VwYXJhdGUgdGhpcyBieSBhZGRpbmcgYW4gYWRkaXRpb25h
bCBmbGFnIGluIHRoZSBjb21wb3NpdGUNCj4+Pj4+IGxheWVyIHRvIHNldCB0aGUgbGluayBzdGF0
ZSBiYXNlZCBvbiB0aGUgZ2FkZ2V0IHN1c3BlbmQgY2FsbGJhY2sNCj4+Pj4+IGNhbGxlZA0KPj4+
Pj4gd2hlbiBVMyBTVVNQRU5EIGludGVycnVwdCBpcyByZWNlaXZlZC4gTGV0IG1lIGtub3cgaWYg
eW91IGZlZWwNCj4+Pj4+IHNlcGFyYXRpbmcgdGhlIHR3byBpcyBhIGJldHRlciBhcHByb2FjaC4N
Cj4+Pj4+DQo+Pj4+DQo+Pj4+IFRoZSByZWFzb24gSSB0aGluayB3ZSBuZWVkIHRvIHNlcGFyYXRl
IGl0IGlzIGJlY2F1c2Ugb2YgcG9pbnQgMy4gQXMgSQ0KPj4+PiBub3RlIGVhcmxpZXIsIHRoZSBz
cGVjIHN0YXRlcyB0aGF0ICJJZiByZW1vdGUgd2FrZSBldmVudCBvY2N1cnMgaW4NCj4+Pj4gbXVs
dGlwbGUgZnVuY3Rpb25zLCBlYWNoIGZ1bmN0aW9uIHNoYWxsIHNlbmQgYSBGdW5jdGlvbiBXYWtl
DQo+Pj4+IE5vdGlmaWNhdGlvbi4iDQo+Pj4+DQo+Pj4+IEJ1dCBpZiB0aGVyZSdzIG5vIHJlbW90
ZSB3YWtlIGV2ZW50LCBhbmQgdGhlIGhvc3QgYnJvdWdodCB0aGUgZGV2aWNlIHVwDQo+Pj4+IGlu
c3RlYWQsIHRoZW4gdGhlIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaXMgcmV0YWluZWQuDQo+Pj4+
DQo+Pj4+IElmIHdlIHNlcGFyYXRlIHRoZXNlIDIgb3BlcmF0aW9ucywgdGhlIGNhbGxlciBjYW4g
Y2hlY2sgd2hldGhlciB0aGUNCj4+Pj4gb3BlcmF0aW9uIHdlbnQgdGhyb3VnaCBwcm9wZXJseS4g
Rm9yIGV4YW1wbGUsIGlmIHRoZSB3YWtldXAoKSBpcw0KPj4+PiBpbml0aWF0ZWQgcHJvcGVybHks
IGJ1dCB0aGUgZnVuY3Rpb24gd2FrZSBkZXZpY2Ugbm90aWZpY2F0aW9uIGRpZG4ndCBnbw0KPj4+
PiB0aHJvdWdoLiBXZSB3b3VsZCBvbmx5IG5lZWQgdG8gcmVzZW5kIHRoZSBkZXZpY2Ugbm90aWZp
Y2F0aW9uIHJhdGhlcg0KPj4+PiB0aGFuIGluaXRpYXRlIHJlbW90ZSB3YWtldXAgYWdhaW4uDQo+
Pj4NCj4+PiBJZiB3ZSBkb24ndCBoYXZlIHRvIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiBmb3Ig
b3RoZXIgaW50ZXJmYWNlcywgd2UNCj4+PiBjYW4gY29tYmluZSB0aGUgb3BlcmF0aW9ucyBoZXJl
IGFzIHlvdSBkaWQuDQo+Pj4NCj4+DQo+PiBJIHN0aWxsIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHNw
bGl0IHVwIHRoZSBvcGVyYXRpb25zLiBUaGUgd2F5IHlvdSdyZQ0KPj4gaGFuZGxpbmcgaXQgbm93
IGlzIG5vdCBjbGVhci4NCj4+DQo+PiBJZiB0aGUgZnVuY19hd2FrZSgpIHJldHVybnMgLUVBR0FJ
TiwgSSdkIGV4cGVjdCB0aGF0IHRoZSByZW1vdGUgd2FrZSBkaWQNCj4+IG5vdCBnbyB0aHJvdWdo
IGFuZCBleHBlY3QgdXNlciB0byByZXRyeSBhZ2Fpbi4gQnV0IGhlcmUgaXQgZG9lcyBpbml0aWF0
ZQ0KPj4gcmVtb3RlIHdha2UsIGJ1dCBpdCBqdXN0IGRvZXMgbm90IHNlbmQgZGV2aWNlIG5vdGlm
aWNhdGlvbiB5ZXQuIFRoaXMgaXMNCj4+IGNvbmZ1c2luZy4NCj4+DQo+PiBBbHNvLCBpbnN0ZWFk
IG9mIGFsbCB0aGUgZnVuY3Rpb24gd2FrZSBoYW5kbGluZyBjb21pbmcgZnJvbSB0aGUgZnVuY3Rp
b24NCj4+IGRyaXZlciwgbm93IHdlIGRlcGVuZCBvbiB0aGUgY29udHJvbGxlciBkcml2ZXIgdG8g
Y2FsbCBmdW5jdGlvbiByZXN1bWUoKQ0KPj4gb24gc3RhdGUgY2hhbmdlIHRvIFUwLCB3aGljaCB3
aWxsIHRyaWdnZXIgZGV2aWNlIG5vdGlmaWNhdGlvbi4gV2hhdA0KPj4gaGFwcGVuIGlmIGl0IGRv
ZXNuJ3QgY2FsbCByZXN1bWUoKS4gVGhlcmUncyB0b28gbWFueSBkZXBlbmRlbmNpZXMgYW5kIGl0
DQo+PiBzZWVtcyBmcmFnaWxlLg0KPj4NCj4+IEkgdGhpbmsgYWxsIHRoaXMgY2FuIGJlIGhhbmRs
ZWQgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gWW91IGNhbiBmaXggdGhlDQo+PiBkd2MzIHdha2V1
cCgpIGFuZCBwb2xsIGZvciBVMC9PTiBzdGF0ZSByYXRoZXIgdGhhbiBSRUNPVkVSWSBzdGF0ZSwg
d2hpY2gNCj4+IGlzIHdoYXQgaXQncyBzdXBwb3NlZCB0byBwb2xsLg0KPiANCj4gRm9yIHRyYW5z
aXRpb25pbmcgZnJvbSBVMyB0byBVMCwgdGhlIGN1cnJlbnQgdXBzdHJlYW0gaW1wbGVtZW50YXRp
b24gaXMNCj4gdG8gcG9sbCBmb3IgVTAgc3RhdGUgd2hlbiBkd2MzX2dhZGdldF93YWtldXAoKSBp
cyBjYWxsZWQgYW5kIGl0IGlzIGENCj4gYmxvY2tpbmcgY2FsbC4gKHRoaXMgaXMgYSBjb21tb24g
QVBJIGZvciBib3RoIEhTIGFuZCBTUykNCj4gDQo+IMKgwqDCoMKgLyogcG9sbCB1bnRpbCBMaW5r
IFN0YXRlIGNoYW5nZXMgdG8gT04gKi8NCj4gwqDCoMKgwqByZXRyaWVzID0gMjAwMDA7DQo+IA0K
PiDCoMKgwqDCoHdoaWxlIChyZXRyaWVzLS0pIHsNCj4gwqDCoMKgwqDCoMKgwqAgcmVnID0gZHdj
M19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCAvKiBp
biBIUywgbWVhbnMgT04gKi8NCj4gwqDCoMKgwqDCoMKgwqAgaWYgKERXQzNfRFNUU19VU0JMTktT
VChyZWcpID09IERXQzNfTElOS19TVEFURV9VMCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsNCj4gwqDCoMKgwqB9DQo+IA0KPiBJbiBteSBleHBlcmltZW50cyBJIGZvdW5kIHRoYXQg
Y2VydGFpbiBob3N0cyB0YWtlIGxvbmdlciB0aW1lIHRvIGRyaXZlDQo+IEhTIHJlc3VtZSBzaWdu
YWxsaW5nIGJldHdlZW4gdGhlIHJlbW90ZSB3YWtldXAgYW5kIHRoZSByZXN1bWUgSyBhbmQgdGhp
cw0KPiB0aW1lIHZhcmllcyBhY3Jvc3MgaG9zdHMuIEhlbmNlIHRoZSBhYm92ZSBwb2xsaW5nIHRp
bWVyIGlzIG5vdCBnZW5lcmljDQo+IGFjcm9zcyBob3N0cy4gU28gaG93IGRvIHdlIGNvbnZlcmdl
IG9uIGEgcG9sbGluZyB0aW1lciB2YWx1ZSB0byB3b3JrDQo+IGFjcm9zcyBIUy9TUyBhbmQgd2l0
aG91dCBibG9ja2luZyB0aGUgc3lzdGVtIGZvciBhIGxvbmcgdGltZT8NCg0KQ2FuJ3Qgd2UgdGFr
ZSB0aGUgdXBwZXIgbGltaXQgb2YgYm90aCBiYXNlIG9uIGV4cGVyaW1lbnQ/IEFuZCBpdA0Kc2hv
dWxkbid0IGJlIGJsb2NraW5nIHRoZSB3aG9sZSBzeXN0ZW0uDQoNCj4gDQo+IFNvbWUgZGF0YSBs
YXllcnMgbGlrZSBUQ1AvSVAgaG9sZCBhIFRYIGxvY2sgd2hpbGUgc2VuZGluZyBkYXRhICh0aGF0
DQo+IGNhdXNlcyBhIHJlbW90ZSB3YWtldXAgZXZlbnQpIGFuZCBoZW5jZSB0aGlzIHdha2V1cCgp
IG1heSBydW4gaW4gYXRvbWljDQo+IGNvbnRleHQuDQoNCldoeSBob2xkIHRoZSBsb2NrIHdoaWxl
IHdhaXRpbmcgZm9yIHRoZSBob3N0IHRvIHdha2V1cD8gVGhlIGhvc3QgaXMNCnN0aWxsIGluYWN0
aXZlLiBBbHNvLCB0aGUgdXNiX2dhZGdldF93YWtldXAoKSBBUEkgZG9lc24ndCBzcGVjaWZ5IHRo
YXQNCml0IG1heSBydW4gaW4gYXRvbWljIGNvbnRleHQuDQoNCj4gDQo+IFRvIG1ha2UgdGhpcyBn
ZW5lcmljIGFjcm9zcyBob3N0cywgSSBoYWQgc3dpdGNoZWQgdG8gaW50ZXJydXB0IGJhc2VkDQo+
IGFwcHJvYWNoLCBlbmFibGluZyBsaW5rIHN0YXRlIGV2ZW50cyBhbmQgcmV0dXJuIGVycm9yIHZh
bHVlIGltbWVkaWF0ZWx5DQo+IGZyb20gdGhlIGR3YzNfZ2FkZ2V0X3dha2V1cCgpIEFQSSBhZnRl
ciBkb2luZyBhIExGUFMgaGFuZHNoYWtlLiBCdXQNCj4geWVhaCwgdGhlbiB3ZSBoYXZlIHRvIHJl
bHkgb24gdGhlIHJlc3VtZSBjYWxsYmFjayBhcyBhbiBpbmRpY2F0aW9uIHRoYXQNCj4gbGluayBp
cyB0cmFuc2l0aW9uZWQgdG8gT04gc3RhdGUuDQo+IA0KDQpCUiwNClRoaW5oDQoNCg==
