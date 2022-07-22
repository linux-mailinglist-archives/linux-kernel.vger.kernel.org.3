Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B941157D78B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiGVABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGVABI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:01:08 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BD18374;
        Thu, 21 Jul 2022 17:01:07 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LLPaHi019269;
        Thu, 21 Jul 2022 17:00:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=EweP5fO84NdM9EIrqkkJkNoGJG00dU9xlhzTDbqkoJE=;
 b=uKWPaVqXaLeKTD8HSF5hvAmoG3KgFsX0E5lOdZULyS/3QGkLYR3jp6cokW+1E6z0udQd
 Zsw7Y/nG18ePNpOSTqNRmT16IVjU5QHVwY84DJ0uNLl8AYYWEmY6vqE0dtiHJ4h9OCAm
 A3EizHlkFLwJSycqEtaFiA88ssFvDqm8YbRhg93TTHU1zOnj+hXtJo75pBcW7bwktwGH
 Gr3VhazI3YPuvyd9ikmnD5CkabAxNWgZNVwP9yAcjVN6ZfushTdh5e9B1cpOfflADW31
 cdMk3G6Dr8Sq0IkmjETd82SZT8SXI9PBBtOogKms9PciXDWkVttfCsifcltpAgwwyK9R dw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3hbvk6kr2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 17:00:54 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BE8FF400E6;
        Fri, 22 Jul 2022 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1658448054; bh=EweP5fO84NdM9EIrqkkJkNoGJG00dU9xlhzTDbqkoJE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=awb2KPEqdsrGXHR4xAqa37RyYMxcgq0LOfFOq7jnVp6Y3zKCX1093lsuUOAF8NrRL
         l/lAZ8D+foKmLM+9q4M9cEpRjROi5z8ORBED3nlB40Xu14p09meCqm1CXHmF8DQhEp
         8JB1ecOXTya6oyj8Q++f4EHiGzdmBvWIJsgx0AsxUtZErt7Idk9X1MwIamO7icCp9A
         9Oaae8v3vmRyX5hDnA9ld2UVREvpGFuNmU1PpCa93KMpQyeRuDFa66HDj5GhRdPLpl
         VolFTwbLZ8FvnkiTSp4kpAz/wwEcCrb7bd4L5U9rWoFYlYrL62rUhZxxz4Ep3ex9+M
         CZVYGuZQ4uKPg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 13A47A006A;
        Fri, 22 Jul 2022 00:00:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F3F56400C5;
        Fri, 22 Jul 2022 00:00:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HXQMruUo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khXKX+0p21nMtvNKgN1tCRo/5bCuU/vgWooKa7XeImClOPseVqkMXhIz0dUdHJoSIlUb9q9SRVjVeTLiUvdGfjigh6ITDWinTiYgRq7EM7XQtwtRxnCEAb0ii+V4dGDIxmAuUfmLlC8wrjr3GCZbvhnjfuVxc6jxcSc3S3oLWHpgFvfhUZcb8uxtNWKlt1zP+bJSgEtg+B7BIanhMHqIp8UVAOBg3jvp2zqa1y/iN23h+PmzHXQQtibjhViRwA+MDCRNVSNvm6n6pGOE2bqVW2fCjBKdRm4kLDxYO6m3zUhooCeLvbAIu3ojfFpxQ7el5YCvyqqwg+CxSyiIMyYjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EweP5fO84NdM9EIrqkkJkNoGJG00dU9xlhzTDbqkoJE=;
 b=Fphw+P8m1uTta6WaRCCgEAFhWcDRD8BemYit3edJMktc2mnEfAp2aSrEX/vjXnrFoLcZS4MAvI4ioGl297WcbURrKcAre9kyq6NwVFSJStq6d9i4boHZcsHo+Y2syveBxHAwbmFzDI38Z1XnTwA3S8rvOtBPFAArQ/1s358a/fkjryWYt6zeComv0KW1/WuDoHOF2RCzSMokzE45WP0UuUBGElNAgkm+E44Uaz8TOc8BWWLA3d9nGvmgP5CfgzTvuyuTDQdMpe0cyCoVYOtR8YnFtPus5MGmL7QQJMvT6WZ7DpQnSn6SqfprcE+TeHH9GomRyxYXG1WyGzUkOIwsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EweP5fO84NdM9EIrqkkJkNoGJG00dU9xlhzTDbqkoJE=;
 b=HXQMruUoQ4+LuDwJbcqFWAKBSq6dRIW77Gtivd38cvWNszHTd4LO4cmzg1LoFk+kxtJJtmi86rBXsyQCPp/A8gtwOHptZ3PLh4WK7mKUoVOwSIKlCp+1cWcHsMH11DDJhKnelVYRN6Yk9FZOoEcj1cajR/I+vlX6CfzQmZEXPq4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Fri, 22 Jul
 2022 00:00:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 00:00:46 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYllCHTDdRJ4wf3U6yBQnRzTv93K2JcEyAgAABOoCAAAIPgIAABW8AgAAWigA=
Date:   Fri, 22 Jul 2022 00:00:46 +0000
Message-ID: <fa172e2c-eff6-002e-3687-d87a2986fd42@synopsys.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
 <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
 <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
 <5d0cf380-e045-fcec-639f-ac2f6a187ca8@synopsys.com>
 <5a57d5b9-b81e-bb09-998b-2915d9ab6b2f@quicinc.com>
In-Reply-To: <5a57d5b9-b81e-bb09-998b-2915d9ab6b2f@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc9072e1-a4ef-482f-3332-08da6b753ad5
x-ms-traffictypediagnostic: DM6PR12MB2971:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NIFqplcPBIdVyqNpf7Ia7GrbEEAG7Ox/+JB4u0AFWHoO0uqa4WZltXhV8k5HEvykRaRlTUhb8S1HGetpW4yYP30BdRlGsL/vFQ/r5p1i67oiRAB/Wbv/Bs9CBvbYE+lPLoXKW1kXM0lsEpmZbMiIJSAja8H+GXlcJB7/oVfRPXXDjVYLVvJw2aaUZkldT+F9Y2MwkKqyxUbNa3Ru3d71eODDktHLcfQFKbbPnj3Ue3Qn82r7bpNa9lTEd4eyx17BgTV2biNXMo8AVdgoB+P5i0duAtVjxKtOKLcrNfyAn+tHiRxCf/lOYKoP20wpXwKd686VX46IYjlOAp7k4G99FigHJuXqhpG+i/OGipcaNKzXKQbNVLx3OD/L40abQCfCfob+Y4ZiSwrhI+QDDyWtuEU36da0BoycnT1/+7c0piMKgJVPJ6y5VHfRoa/74/gUx85Mt4O9AQLNEh6SyU8iL5IywxdqnKBREMCRQ5+eyPTfklH6Mxo0qU5fCM4rex/wG4ryJ/+Bhz8YsgyWvxWlyBxuSeq9mArkmJHtwl0Q6hGZvXdsOmb6mLa4P09QuIMOwhXpvz12hqE5e2lt2YwWOMlkxv/J4YNvQxNZjGV0Lr9UbhJyYM0rUkINON6Y8ZsVG0lQfyNx5MZSrCMLU26G08oXlMiqSUMtkIdN+NH5o3G8cb9w68YhJjKHkqnrvB5LawUrCEebl/Pc/NZbKf1PhgVCV6Xp02Ky3p4NgL/1i4rcUihpXhtfMrMMAV5owq5cKfcUQVoM/PEwElgQol1KM3vIolPN4kUgNV2fFnWIkm9mxWeyvyHJWS56lxyWcQWsIxh1L7eIu/NMzXe2rRwZ+IyO/sURRRn9YqFVGQj1R/J8jVTRKIoEfhXTRyQkWltm48T+1SWAvml58G83NKVRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(53546011)(6512007)(31696002)(86362001)(31686004)(38070700005)(71200400001)(478600001)(6486002)(186003)(2616005)(36756003)(41300700001)(66446008)(38100700002)(6506007)(966005)(5660300002)(76116006)(110136005)(8936002)(54906003)(4326008)(66946007)(64756008)(26005)(122000001)(8676002)(83380400001)(66476007)(66556008)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVpVN2tPS1JxajZhQmdmMEFCNTJvcUtHa3gvUit4Q2NLcjRSL2NZY29rREFJ?=
 =?utf-8?B?VU5hYU50Unl4cVZDbGdXUzNRcE5hL2ZKbXV2Y3VkenB0T0tON1JqTmhPUm9m?=
 =?utf-8?B?eWh1aC8wMElBUzFmUjFJaTRDN1ZrL0dZdmpvdFVLTTF1WnNkQnZFQmNIV0xX?=
 =?utf-8?B?aE94TnY1YlVaeENPbUNERmFvVjRPaS9VbWhqcTB2LzU2TkhPMTRuOWwva3NP?=
 =?utf-8?B?a1ozTnNaV0FGSVVtMy9LeHd2RkpOaGxHVWRabytRS1pvMzJReTNTTFlmb0hY?=
 =?utf-8?B?S1ByeGRoWHlKNmFRelV4MlZNTWRHdjk5ZDNnRG00a0UxeWdaVmkrWmRyblB5?=
 =?utf-8?B?bXJXdHB1TUduajkvc1dFMldHQ04vaDlKajNBbEN0VUprOElML2tTWHNRSjgv?=
 =?utf-8?B?eXJlUjRwZkZlUnIvTVdNYVpFeUtMeURlNkdKT2VnNjFFNndsZVZqODl6NUpD?=
 =?utf-8?B?RGhaNEZqcy9ldkhYMDYwK0JjSk9wMW5VdVcwODYvSnVEdmxUT3lnaHdTREgv?=
 =?utf-8?B?b1YvMzFNNVJ5dGttT2I3SmFGZTBQRUZLOXFUdHFwNzdUbTJESFVEMzdIQzVh?=
 =?utf-8?B?d25rU095MzBVbnNUaTZqa1dtS0VaeGZCQ3J3TzhHZHFENUtrUmZEN1hiM2x1?=
 =?utf-8?B?aVRnYlluNTR1Ymk2TjFDV3YwVHJ4QzFscEVHRmFRQ1N5MDlIODJNVGI2NENS?=
 =?utf-8?B?THBiQTFYU1VSYjdwU2hnZ2MvNnBhcU5idEdiWWkrS1NlcEZkdTZTaVlBUDRh?=
 =?utf-8?B?dHQ1Tk5RSWcwaCtra0dJWERab2kwZ2FoSjBYeG1kVzhnS2cvWDlleEdsaW9Q?=
 =?utf-8?B?Tk95YURsaVhuS3M5Y2gzUEFocVJydENjamUrcVlGY1VJQ0JGOXQ0TE8zdUJR?=
 =?utf-8?B?RThtN0pQeHZtMG5sR0d4TVBzWEJkM2tZWHBUZUNVQVlRNHNiWEwwZTFHSmVy?=
 =?utf-8?B?L3ZhekZPTnhyZ0RtY3NMOTd6MHp0cE5jZmkzRzJmWE1BN3YwKzM3Tk93L0d0?=
 =?utf-8?B?cTNTK2t3NlozZS9vQzNZQVdkK2VydjM0WmlKSUQrR0o0SlFadkoxYmNlZTE0?=
 =?utf-8?B?UlZxUDJOMUw1bjBTellPRlNyU21zUytldkIzZEJ3azIvTTZ1b3I2VTZHVU05?=
 =?utf-8?B?VkhYUWx5ekIwRWRPSEg5cmM0bmkyd3F0aDVoQVdLUC9YOExxdTNGakRaSGdh?=
 =?utf-8?B?QWJaQUZEVkh0K3ZPM1k4ZEtkdVpSRUZXWVVJWlk3SmFWSE9qZkJTUW5PZTF5?=
 =?utf-8?B?OFczWTJJTHVxRWM1SGtBSEwyM1R4UWQ1UWlTVXpiOHR5QjEvOTZHekY1di9y?=
 =?utf-8?B?VkRnalhvaEcyVFo5VmtWalZYWGllRTdmZXhta0MzUzlMVnk1cG1mcm9aajk0?=
 =?utf-8?B?Yk1NMGtkQnhvTm5FWVlKQWJDenJhbTM2RXRmSXFSM3NHTEZkbzdFS08vVXV4?=
 =?utf-8?B?MlIrdnBsbUVNRSsya3NDYzZvaE5iRHphNzk3OG1STHJPRWRpcWVvOXB1YnFQ?=
 =?utf-8?B?RlZEOWUyeDJQM1dETWw0WXNKSmtzUGIyNEFrVHNacmw5V1JkblJTZW1QYmx2?=
 =?utf-8?B?K1hkc2RzMnduVko0VHR1YStYRVRVa1dXMFc5T0lCby9RWjhjTDViWndlZW1p?=
 =?utf-8?B?RXZMMS9PVW9IeitBOGRHMy92emFTRE0vSlN1OXFEMENwbGZ1NVZuTUdHaEJJ?=
 =?utf-8?B?TCtQdHRsSmd2SWV0T1IyTm04N2dEMzlIajNmMGhvTGtVZ3FoQzZBb3NaTnE0?=
 =?utf-8?B?ajc2eGF6Wi8yVVlIRk5FYmdxY3dDZjlKSUhZS0x2ZTQ0QVJjZTM4WllTL0NU?=
 =?utf-8?B?SjVLbEMycnhLc2lFVUtLL2QvM0hqYjg5ZllmSFlxUnJDUG1Fd2VESHJodlJx?=
 =?utf-8?B?b0VRRUV3MlE4U3dWeVJmbFh4MHBSaDMzSHQ5U3pQK2JwRGlDY3B0L3dMS2Nt?=
 =?utf-8?B?SkhIK0Q1K0JTM3V1NEZFK2tPc0l6ZTlrWFhsZXAwOUxkNDJKQms3NFExb3lZ?=
 =?utf-8?B?Uko0N292ektOb0Z5SVJYT2pOTVk3alI5RC9lbmVudGdrZzFNbjBpamRBNWxL?=
 =?utf-8?B?UjRFTFd2NEVxNno4YWlpRFBhN2lzS3ZBZ3JHVGF3RzBLQ1BWTEUzWEdMV0NC?=
 =?utf-8?Q?+jurcZEVH/snLRSyfHERM83UH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C635B8654363145BA6E7964B5268A9E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9072e1-a4ef-482f-3332-08da6b753ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 00:00:46.8430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vkd8ji88Pp63n6xxzGxpLeANo8tLeEoKoTVR2Lio83Kaj6pzCDshQRPklCc0LNiSwMFcJ8bo3ohPCeZXKHpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
X-Proofpoint-GUID: v-u7HUrqNq_vDVIY4uSUES9WpYfTZIGb
X-Proofpoint-ORIG-GUID: v-u7HUrqNq_vDVIY4uSUES9WpYfTZIGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMS8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzIxLzIwMjIgMzoyMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gT24gNy8yMS8yMDIyLCBX
ZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiA3LzIxLzIwMjIg
MzowOCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+PiBIaSBXZXNsZXksDQo+Pj4+DQo+Pj4+
IE9uIDcvMTIvMjAyMiwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+Pj4gSWYgc29mdCBkaXNjb25u
ZWN0IGlzIGluIHByb2dyZXNzLCBhbGxvdyB0aGUgZW5keGZlciBjb21tYW5kIHRvIGJlDQo+Pj4+
PiBzZW50LA0KPj4+Pj4gd2l0aG91dCB0aGlzLCB0aGVyZSBpcyBhbiBpc3N1ZSB3aGVyZSB0aGUg
c3RvcCBhY3RpdmUgdHJhbnNmZXIgY2FsbA0KPj4+Pj4gKGR1cmluZyBwdWxsdXAgZGlzYWJsZSkg
d291bGRuJ3QgYWN0dWFsbHkgaXNzdWUgdGhlIGVuZHhmZXIgY29tbWFuZCwNCj4+Pj4+IHdoaWxl
IGNsZWFyaW5nIHRoZSBERVAgZmxhZy4NCj4+Pj4+DQo+Pj4+PiBJbiBhZGRpdGlvbiwgaWYgdGhl
IERXQzNfRVBfREVMQVlfU1RPUCBmbGFnIHdhcyBzZXQgYmVmb3JlIHNvZnQNCj4+Pj4+IGRpc2Nv
bm5lY3QNCj4+Pj4+IHN0YXJ0ZWQgKGkuZS4gZnJvbSB0aGUgZGVxdWV1ZSBwYXRoKSwgZW5zdXJl
IHRoYXQgd2hlbiB0aGUgRVAwDQo+Pj4+PiB0cmFuc2FjdGlvbg0KPj4+Pj4gY29tcGxldGVzIGR1
cmluZyBzb2Z0IGRpc2Nvbm5lY3QsIHRvIGlzc3VlIHRoZSBlbmR4ZmVyIHdpdGggdGhlIGZvcmNl
DQo+Pj4+PiBwYXJhbWV0ZXIgc2V0LCBhcyBpdCBkb2VzIG5vdCBleHBlY3QgYSBjb21tYW5kIGNv
bXBsZXRlIGV2ZW50Lg0KPj4+Pj4NCj4+Pj4+IEZpeGVzOiBlNGNmNjU4MGFjNzQwICgidXNiOiBk
d2MzOiBnYWRnZXQ6IFdhaXQgZm9yIGVwMCB4ZmVycyB0bw0KPj4+Pj4gY29tcGxldGUgZHVyaW5n
IGRlcXVldWUiKQ0KPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNf
d2NoZW5nQHF1aWNpbmMuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiBMaW5rOg0KPj4+Pj4gaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8x
YTFhNTQ4NS03OTBlLTc5Y2UtZjVhNi0xZTk2ZDliNDlhNDdAc3lub3BzeXMuY29tL19fOyEhQTRG
MlI5R19wZyFjWFcyVGxBTFlXblhOUGctTm9NRlVyUThLMWVnRVppUWl6WjVDQTFET00xR2N3NHRm
T1VMeS1fMmVNR3ZMOHBRUHRlNWRTY0ZPTi0wd3hIMmVYdThpakVRVWJzJCANCj4+Pj4+DQo+Pj4+
Pg0KPj4+Pj4gwqDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmPCoMKgwqAgfCAzICstLQ0KPj4+
Pj4gwqDCoMKgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1ICsrKystDQo+Pj4+PiDCoMKg
wqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+
Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jDQo+Pj4+PiBpbmRleCA1MDZlZjcxN2ZkYzAuLjU4NTFiMGU5ZGIwYSAxMDA2
NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZXAwLmMNCj4+Pj4+IEBAIC0yOTAsOCArMjkwLDcgQEAgdm9pZCBkd2MzX2Vw
MF9vdXRfc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCEoZHdjM19lcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPj4+Pj4gwqDCoMKgIC3CoMKg
wqDCoMKgwqDCoCBkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KPj4+Pg0K
Pj4+PiBJZiB3ZSBkb24ndCBjbGVhciB0aGlzIGZsYWcgaGVyZSwNCj4+Pj4NCj4+Pg0KPj4+IFRo
aXMgaXMgd2h5IEkgYWRkZWQgdGhlIGR3Yy0+Y29ubmVjdGVkIGFyZ3VtZW50IHRvIGNvbnRyb2wg
dGhlDQo+Pj4gImludGVycnVwdCIgYXJndW1lbnQuDQo+Pj4NCj4+Pj4+IC0gZHdjM19zdG9wX2Fj
dGl2ZV90cmFuc2Zlcihkd2MzX2VwLCB0cnVlLCB0cnVlKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGR3YzNfZXAsIHRydWUsIGR3Yy0+Y29ubmVjdGVk
KTsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+IMKgwqDCoCB9DQo+Pj4+PiDCoMKgwqAg
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgDQo+Pj4+PiBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+IGluZGV4IGVlODViNzczZTNmZS4uNDFiNzAwNzM1OGRl
IDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+Pj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+Pj4gQEAgLTE2OTMsNiArMTY5Myw3IEBA
IHN0YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdA0KPj4+Pj4gZHdj
M19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoCBlbHNlIGlmICghcmV0KQ0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXAtPmZsYWdzIHw9IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkc7DQo+Pj4+PiArwqDCoMKg
IGRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RPUDsNCj4+Pj4+IMKgwqDCoCDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsNCj4+Pj4+IMKgwqDCoCB9DQo+Pj4+PiBAQCAtMzY4Niw4ICszNjg3
LDEwIEBAIHZvaWQgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcA0KPj4+
Pj4gKmRlcCwgYm9vbCBmb3JjZSwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGlmIChkZXAtPm51bWJl
ciA8PSAxICYmIGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX0RBVEFfUEhBU0UpDQo+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4+IMKgwqDCoCArwqDCoMKgIGlmIChpbnRlcnJ1
cHQgJiYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybjsNCj4+Pj4+ICsNCj4+Pj4NCj4+Pj4gdGhlbiBpdCBtYXkgbm90IGdvIHRo
cm91Z2ggaGVyZS4gSSB0aGluayBJIG1hZGUgdGhpcyBzYW1lIG1pc3Rha2UgDQo+Pj4+IGluIG15
DQo+Pj4+IHByZXZpb3VzIHN1Z2dlc3Rpb24uDQo+Pj4+DQo+Pj4NCj4+PiBTaW5jZSBkd2MtPmNv
bm5lY3RlZCBpcyBzZXQgdG8gRkFMU0UgYmVmb3JlIHdlIGNhbGwgc3RvcCBhY3RpdmUNCj4+PiB0
cmFuc2ZlcnMsIGlmIHdlIGV2ZXIgcnVuIGludG8gYSBzaXR1YXRpb24gd2hlcmUgZGVsYXllZCBz
dG9wIGlzIHNldA0KPj4+IGFscmVhZHksIHRoZW4gaXQgc2hvdWxkIGdvIHRocm91Z2guDQo+Pj4N
Cj4+DQo+PiBUaGVuIHRoZSBjaGVjayBmb3IgcmVxdWVzdCBkZXF1ZXVlIHRoYXQgd2UgZGlkIHBy
ZXZpb3VzbHkgd2lsbCBub3Qgd29yaw0KPj4gYW55bW9yZS4NCj4+DQo+DQo+IENvdWxkIHlvdSBo
ZWxwIGNsYXJpZnk/wqAgVGhlIHB1bGx1cCByZWZhY3RvciBraW5kIG9mIHNoaWZ0ZWQgc29tZSBv
ZiANCj4gdGhlIHByZXZpb3VzIGNoZWNrcyB3ZSBoYWQgaW4gdGhlIGRlcXVldWUgcGF0aCwgYW5k
IGNvbWJpbmVkIHdpdGggd2l0aCANCj4gdGhlIHN0b3AgYWN0aXZlIHRyYW5zZmVyIGNoZWNrcy4N
Cj4NCj4gSSB0aGluayB0aGVyZSB3YXMgYW4gaXNzdWUgdy8gdGhlIHBhdGNoIEkgc3VibWl0dGVk
IHRob3VnaC7CoCB0aGUgYWJvdmUgDQo+IHNuaXBwZXQgc2hvdWxkIGJlIHJlcGxhY2luZyB3aGF0
IGlzIHRoZXJlOg0KPg0KPiB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3
YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwNCj4gwqDCoMKgwqBib29sIGludGVycnVwdCkNCj4gew0K
PiAuLi4NCj4gwqDCoMKgwqBpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFS
VEVEKSB8fA0KPiDCoMKgwqDCoMKgwqDCoCAvKiBGb2xsb3dpbmcgc2hvdWxkIGJlIHJlbW92ZWQg
LS0tIChkZXAtPmZsYWdzICYgDQo+IERXQzNfRVBfREVMQVlfU1RPUCkgfHwgKi8NCj4gwqDCoMKg
wqDCoMKgwqAgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HKSkNCj4g
wqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPg0KDQpSZXF1ZXN0IGRlcXVldWUgY2FuIG9jY3VyIHdo
aWxlIHRoZSBkZXZpY2UgaXMgY29ubmVjdGVkLiBUaGUgDQpEV0MzX0VQX0RFTEFZX1NUT1AgaW50
ZW50aW9uIGlzIHRvIGRlbGF5IHNlbmRpbmcgdGhlIEVuZCBUcmFuc2ZlciANCmNvbW1hbmQgdW50
aWwgdGhlIFNFVFVQIHN0YWdlIGlzIHByZXBhcmVkLiBJZiB3ZSBkb24ndCBjbGVhciB0aGUgZmxh
ZyANCmJlZm9yZSB0aGUgZmxhZyBjaGVjaywgdGhlbiB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmQg
d2lsbCBub3QgZ28gdGhyb3VnaC4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
