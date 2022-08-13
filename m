Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD55917DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiHMAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiHMAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:46:17 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC042BB1C;
        Fri, 12 Aug 2022 17:46:16 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CF3qjj017757;
        Fri, 12 Aug 2022 17:46:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=w4HSBgX/OdpU3ve9bMjOsYmSMYxLeLmHcjaqPrxKdBk=;
 b=aC5mkck6RdUnsuRSKClUMhnZEWPGyPmPe+Lq/cmFWRKrJ2XjSaaxWJNwc6njW2xi7R0r
 T0aBbBMtbT9yTQAdefZ3MrhbSJ/oXG1ZRjJ3dtLsWMG+fof14svaJ9gDSPGZZZ2hvDjL
 8YDGMjjEs6+ohN0mXWuGzq61izxEfuTu8AhdPOSKLj+q3YKTPqwwKuC9WGMHEFi84mA5
 DvrHHkkJT9ieP2CqlAPLDtsFGr4N0c77tntLTP1TgPB5Dk3qN2uzo87UnluX8su7HEWr
 zuoZq61rNXDbKNm5u9ubfqktChnp79L0Qrqqsnj7XTFByYX3HAWTHC3wBlD0Bp7eYlQp YA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3huwprt2ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 17:46:08 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2635D40052;
        Sat, 13 Aug 2022 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1660351568; bh=w4HSBgX/OdpU3ve9bMjOsYmSMYxLeLmHcjaqPrxKdBk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LF8cr7wDkg+LSB9SuJTGZQzVev/nk3BmVE9/eq7HtH+aeIx3d5cfyfkVoZxIZtFCb
         YLfu28ewbP2rcbhd+kLtSUG0gZzvjdDY224l7B+kgfAc9EPmCUaROLwy1XrhnnHmqj
         AUbiLgn64AFSNVwlfPsAqxzHA/QAdOJ/VQZvXjBnaBQVuOpzL/fDYCKMqon49GUJvA
         NXNY0vbawFHaouQGSqu8L1L9KqIccP0nhgrRtc2qUxfjsDEpDznuP0s9GcDJnw38GI
         Kg9FLhfVdoHacDFQwicusEAY9aX+xb0PHx03NGFG64SpD3G9iFYagpKvsvn9CjuRhn
         09ufEuzHIsnRQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6FBA2A00A2;
        Sat, 13 Aug 2022 00:46:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4C0C240073;
        Sat, 13 Aug 2022 00:46:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UpvG1tNy";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxfdWybz8/PS70OUy7sTqZwHhBWaKLd8souwli27Y4sMmDAXYI8W+KLZG4W+gCQ5xBj2CS80jPE/kDbxcsHPtw2isVSdNplh5KaDwes4rXoJrfmsI7NnxMA4ibFslzYd7CPkTWm1J+Ba4tgf+PMjyZMXlywCnjvXam65MPoC79mxNgvuUTkD4Bo1c/U/d03YE1ni7BmR1YS5l9Sxyv0PXJnoqx1SSL7SODrIqva/DLsCxQCn8d1IIF73UKP2k7a6pd3+DuFZd6nbDdmdZ70rOI9JmWqP1gXZWDxa/K56D83NBSORT9Jaa8vi5dqkJvNBC9B/LY+DL74Jlz0ydP03uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4HSBgX/OdpU3ve9bMjOsYmSMYxLeLmHcjaqPrxKdBk=;
 b=I/WUA7fMuBZmhjD4KCrTeFvvgdlJSA3rJk448I9hIM7CWwZjklWqxMYs1J39h3/0fVyFy8MBuiGaIXC+tyElq/sEoEKNXAeUqeznxT3tQdUdg3ecGnoTwomBx1dlxong0mtJ9r2yoSgasmdTPXWP+vNwghgp4Mg+vurya7kPq0QMzfzWwKLGuiuHwAmNtJiXaL6bbYK1BU9RjfrtpNMUefs98ph/VjtzsicWbAqCXaon78qniilwo9zPc3CDa/pgBDqnpBynPMLG7LnwhC2iecl67rYh+I+AbIrpJ1b66NKYEYNawEpgmJwuDwP75g8FwK23YYtsJwVqTXYWKZeDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4HSBgX/OdpU3ve9bMjOsYmSMYxLeLmHcjaqPrxKdBk=;
 b=UpvG1tNyU+D32fkaKyWqEstdvJktzyu7D1/BAcf25PcmMqvSXUlvib6+5RfqA+wgUcaa8q5L8mQAMalr3wedSoqVpuxUVbdXoZiPpx2ZJZRqe62oMQ8BSKgbMZ7fmL/R2EoGEw/3l2HM1R6kNco4i0ETFAlm5zQkaqbgvyk7E0w=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sat, 13 Aug
 2022 00:46:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5525.011; Sat, 13 Aug 2022
 00:46:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Serrao <quic_eserrao@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4CAAXhZgA==
Date:   Sat, 13 Aug 2022 00:46:01 +0000
Message-ID: <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
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
In-Reply-To: <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9758ed62-e185-4c26-9016-08da7cc53240
x-ms-traffictypediagnostic: MW4PR12MB6898:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9C7VMz/7OJO5pkeXH2DPNzlJBE6ZwAtHCi1k97lBlrZphO3KYP3ERrLiYJmEq6RISKK/MceyYpvtqP589id/snBdEHkayYEt2Qx4AzEzA9zqRc1CamoC5jgekYM8mWqiswBtc8RxG3pTIn9xUyZgmfeNvXJP6Xc6yRSizQ8QNqwVLrOoyMO6p8Hy+fGfm8VI7mXcZ1H3hMIgFTpX2nH/IgLDwRvIwbluQuAT+TZxJCy+4p+I3JplVu5GsfSe2ZxkJh2uHydjPUfnh7hRJMcKIgdi6nDwt3iReZMXoOq3NfOMRMuxyeVQ7DugtJHSuOlJVUZ2F4o9p67kdrxn4Ow74COv5vvYFfqcOK+u+v7YaKEwj5X3trUpQKrzPgrsjaxxu7M9D2gnxdCB0J9yM62DkufAEj9NlW9Tyw4l5vJzIopIXjYibQ6CmJniSfIoWlaV3zZ2xjP9KXRqINno5LxD5v9l7Tn70YZYeup8aTLsB2x3bi82DpXNyMPDdD+HfTdnNzS0qyknHJnrnaaHgVL+C+UJvsDSST7l2VGadhTfrfW9eshxPMUtdt8oQB78nkwGi+yLygWFvGPeG3EkCqcCnATsxl+BDYoE33V+9nP7jGoQ9LZvMmE33olbfMaixJiUgoB7rv2rhWcSlhNgaf5+8RDQJAlaihfAgrt+oI/d8goZ/Xf/PrZ+v0ew6aW4TpYqoXqxDUFm0ZAOjOGARUfF9PhkK0WPGE/cO4geUMIGlKFmAdKr+Fsttvw4+RdGHSus81CiqfUDWK74pnk+CJTwoC8fE1aQSTBtXapvW1tXIo+ei85n1+NiHlQGuvy4aN5EDsqrC0g8qHCIJ4tmed68bTwWytHYn2faU+1+Ppl2MDgwXLZwxFrZRMgubqsUP4gO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(396003)(39860400002)(376002)(36756003)(76116006)(2906002)(83380400001)(38100700002)(2616005)(122000001)(186003)(31686004)(26005)(6512007)(41300700001)(31696002)(86362001)(8936002)(5660300002)(6506007)(53546011)(38070700005)(478600001)(6486002)(64756008)(66476007)(8676002)(66556008)(4326008)(66446008)(316002)(71200400001)(66946007)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEQ1Qkt4NVRGR1hpSEUvSTNwRnRSekhiekdkNGlzZVBZbWU0NG9vOWlBem1B?=
 =?utf-8?B?WWh4RUdMWDBVSnBPdGJHN0w0U09LMEZ5OXkrZC9BNWdWakxRL1dIODNzRGph?=
 =?utf-8?B?dUhKNENvcEFMUVFRSng1TnA4SjA0SEo3eTQvaXU4b0hRNVhNRnBIZDRMcjVW?=
 =?utf-8?B?dFUwb2ZqOGVoak03WkVrRmRnbE8zYkF0a2hDTzdOUzRkc1NsNnZoay9UMXhH?=
 =?utf-8?B?anh3TVpnQkNnOWpac1Z1UHp3SkJ2dHEvdzMwQlkvaDJKRmUwU29mRlBhMmU2?=
 =?utf-8?B?Y3p0bUl5WDh2bnVUSjAwQlhmaGRVMEhVRVVST0RnRjh1RERYdmJ0MmVTUGhM?=
 =?utf-8?B?VklTdllHRXVSbWU4aGxIUnNpWlVJZnF1QWpzeHYvT3hoWkFWeCtVbklyd28w?=
 =?utf-8?B?NDN4WTFVWFpXT080enl6VWl3UTEyNFVFUjRucHdON3NqdGtHYzQ3TDhLNzQx?=
 =?utf-8?B?YmEwSytiRzY4U2xvWkErdkoxck1KTVVpSW1zaCtQUTdrNTNjRnEvNkxQTmhn?=
 =?utf-8?B?ZlJoQUJJRkZpdEtaYit1RXBnWWtoQ0hIL3ZnQzFicVF4Rk0zTlRGcHFUUWJo?=
 =?utf-8?B?dE9WVjdxSmQ3MC9nUmxBYzV6UnZtck0zMXowREU3VVdzRU9EWlp1YTdpSU14?=
 =?utf-8?B?V0o3S1NwOEppLzlISHU0MEhYWTZTb0JhdjNCUDR5SVU4RCsrV1ZZTjRsMys0?=
 =?utf-8?B?UG5vR2pSYTNxSStXZjdJWklDMERKSm9TaXA4ajFXMEVIVGVESXFYWWt6ZVdB?=
 =?utf-8?B?NGUyMkFiUUxWdktLbGl5dDB1Zy9sblc0aEZqeGh2T1gzenBDcktpMW1Wa3Ri?=
 =?utf-8?B?Vm01dUk2TmsvSGxxYVZvbjBFUWJTQ28yWkl0SzFBOTlqYUkyKy9hMytrMlkv?=
 =?utf-8?B?SXFtRUFEY0JLQ3lIWThGaDJLbi8xdVN5QUJtaWY3Sml3QkxqMFdxeVdBV2sr?=
 =?utf-8?B?dFdmTnRuTWM3SlorRTlaU0dRcDgwWGphQy96VVZLWVBsYWg0Y0FoQWxxcXB5?=
 =?utf-8?B?SWFlSVlaemg1L2VtdjUvMWdLaS93Wk1UbU8yV0RvNEYydlpKZE1SeTd1WHVo?=
 =?utf-8?B?UmVOQVZwVGlXcjBhamZlZUZmNm9KaU01YzVBS1hkYXdEUjZmWEYyU3JhTHdI?=
 =?utf-8?B?SXNkelBIZ1p6Wkl4ZjI2ZVJZOCtnSXE5QTRXUnZRSmZOb2VWZ2ZZRzJEWVNr?=
 =?utf-8?B?eFgzbXZQREJUZDVBYVVSVVg4YXNQeFNNbWgxM0QzSmdxMzJ0ZExKdDRKdDRK?=
 =?utf-8?B?NEczZGhqSFYvUzZtMlhtR3ZOZmNSdEc1K09vZWMxTWdhZnVNUlMxZi83aDlo?=
 =?utf-8?B?ZmJXTEJHM2RXUDhvaDVxVUJNdkh4UmtLb1dSamxlR2dDQkxKWGkyWFFNRHVF?=
 =?utf-8?B?S00zUUpQeURkNkhwZ09WZlRxRTY4SUk3eTZqN0Z3VCs3YkVHRTNkbEtJbmVt?=
 =?utf-8?B?NStFL2tCZlNtSGFxLzkzS2RPYW9Gbk5CTm0rU3h0aW5IdlBXZHI5Y3k2WkND?=
 =?utf-8?B?VlF2b2prR0g5TkxOcU5lWStRM2c5dkVTVVlKaTVGdU51WDRRdEFkbmo3eStG?=
 =?utf-8?B?UW9WSkh3cHlSZlRtSUp6VGVoQm1idTBHT0xpKzZPYThBdWxNY1luWXR4MDl6?=
 =?utf-8?B?VU1CMk1mdEJDT3kybWJSTHJrWWVNOWcyQWRzM1hWNiswM1JqamFYNE02UTdh?=
 =?utf-8?B?eFJndVFTTGx5N081ZVFFK3pNYzc3M3p5d0JDNkJzY3lMS1NsdjNXanRDS25v?=
 =?utf-8?B?L1dNNGpxMmN6SGw0ZWRYemYvR3NRLzhZZWZXeXZWVHc4a2pSMzdocHAwTnAx?=
 =?utf-8?B?WWQyY1crNkVTcnJBNjYraDY5V0kwSmRKejZsdG5kWmdaUGlyNzZCK2lIODAv?=
 =?utf-8?B?WDBqcVh4SXpMbXpWcGJ5a3R2UkN1dk5FU1FPTTFOaEJodmJ0NU41a0p6T1Ur?=
 =?utf-8?B?cG9YR2NraHlaRHV0Mk9TUW9nRFdjbDNkR1dReDFETDF2N3oxZHFwWDdKRHdI?=
 =?utf-8?B?WkFYOExvdzRZOUIxZnE5MllpSE4wY3BFdngzN25jWkFzdklEcmdxTkFBWXFS?=
 =?utf-8?B?TXBPVURybVV3Wmg4YTBqRlBNSWc3aGZ5UmhIUGdjeHl6REpJQm1mSzhZdnlj?=
 =?utf-8?Q?Lv5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25669539AE1FAB4884B684FFF05F835B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UytsaTZ2TldkNmVzOTJ2QlpDVHR0VGpJZm9BT3pTY2xZNTc1YStVblVpMjcw?=
 =?utf-8?B?d1A2TTBvN1FQMDY0Q0lZZjdEQjFQSnNMZnRwcUxyOFo1MytUV2tQYzZqcjVk?=
 =?utf-8?B?Uk1LV0ZuVUdhdjFSU0VrTHk1emg5cnpkazRYNU01VGtJbGJ0YU9TNEFwUS9p?=
 =?utf-8?B?eUpGY1ZkeitMT1FxcGVGbktqZDhsQ2xsZFRieTVFUS92alhzOGlqanhWU1Ew?=
 =?utf-8?B?Q012TlhpL2hjWjBmanQxTkFOVERDbDZHZ3pRZnZCek01c1pWUlMwOUp0VEsr?=
 =?utf-8?B?SVh2aSt0c3hjZ0lNbHQ4d3UvWENHc1poUGFzRm4vQkxDQjltSG1wSHJLU2hN?=
 =?utf-8?B?Wk1BWXZoVmNtVzZtbnNzVml5WmJFMVRIQ1hURnI4RnFFK3Z4U2ZVOVlidm56?=
 =?utf-8?B?SlFja1Y4N0pjSTFGeU1kL1BnRkF0ZHl0SlA0eDlWOWZqZWI1ZXpTSjI3RjR3?=
 =?utf-8?B?ZE5ZdmoralFtVXQ1andQS21SVThRdkN2QUk4V1BLRXppaEI0enhHS0gvR1FG?=
 =?utf-8?B?eXJ6V2FyZXoxQTl0Qmw4SWtoekE3MVVlRWcrbWhxTFVtaWNnbEMvZEtpSUp1?=
 =?utf-8?B?UU9CZDZPUkIzRUhjVGdCbEFDY04wdHh4d1NkNFdsbVFmWjk3RmI5NFBFSzVZ?=
 =?utf-8?B?SjRiWmZWR3FjWEk2N0pGcHRmblAyV25WbnI4eEQ5My9JV3JKVzVlVkZlT1ZH?=
 =?utf-8?B?OHBhUlVBODAwbjdnTDVRTUFXOWRFMjVHTGpuWWdIRXFYTFpvclZ4YTcrNVl5?=
 =?utf-8?B?YjQ2REtGYmNZdFVrYmhZSHY5emFtQnkvL3NPbWhUZkF5S25Mc0VsNXJ6UGlB?=
 =?utf-8?B?N3prQmpKeVlwRUJhbVhwVXBLbXB0MHd6T0JvekYyRGZlWFNxc3pQK1h1ZkRI?=
 =?utf-8?B?L0NnM0xrczdETnlzZ3FLbzRneVlpd3ovaStaQzVwS2J6WmJURGRlNzZBRmNN?=
 =?utf-8?B?Qzg1SlRRdUM5NCt4b2hzbmI3TEV1bkJ1QlEzOUR1Ym5qaUZiUFEzVkFYdDhK?=
 =?utf-8?B?TU0zMHlKOXF0cHE3b2dhU2dTckhPS29jNXg1NHVhYlRuU2FNU0Q1cWJhdE5t?=
 =?utf-8?B?RlVjWDNkTE9BaG13WUc1UnJUQklWME5ZMWd3Tmt0TXM5Y2JXYk94dFVaSUxC?=
 =?utf-8?B?SFNIVFhSd3A5RStFWDJQZVMvSlk5dm1uOFRqT1lMZUZWRDNKKzRUSDFObWNB?=
 =?utf-8?B?ME9pWXRlVk5RemU0aVErYkduamZTY01Jd1lFTzRwSGlvRDU5T09DZjYxbC96?=
 =?utf-8?B?Nit4ZU82a0swdWV3RWg3TmU5U2xIa0VSNzYxeGZlMEo5d0ltY2o3SDdnc05t?=
 =?utf-8?B?dG0rQzgxeHZpSFlsU25ROTlSZDVZZlB2NGlrN3p6SElYOHhscG9FamtSRG1n?=
 =?utf-8?B?S2tha1I0QXZLeXV4N1A2NW1JdkJWSFdtUzFSaEFQaDFLQ2lrYWswVjZQdnpT?=
 =?utf-8?B?VUg5MzlRV0dQQk1pellmUEtLdDEvZHh4Y0pnd3A0UzNGdnlaUkRDM0s3MXYy?=
 =?utf-8?B?R0xkdllYSVFXajVPdFdzSHZKd3FlRld1S2RTNDBWUjBjN0JnWE4wOVNaR1RH?=
 =?utf-8?B?MTRHbkVkSklXSlVWWjF0bjR5c3VUSk11WXd6Z0V2UGYzVnJOQ2F3OVJVdXRG?=
 =?utf-8?B?ZmJKNGEyR1locUZLMjVNRDhoZ3NOWHc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9758ed62-e185-4c26-9016-08da7cc53240
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2022 00:46:01.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBRzRKmAiLFLpmRbwbr8cgcOAHfpo33AqctwLiAp9TojPBgOkKV03jBj603nmmMIbLGW9TvdpW8frayJ15MhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Proofpoint-ORIG-GUID: MdBW17Ib7LY14LaTrS1dutKKCMB252ui
X-Proofpoint-GUID: MdBW17Ib7LY14LaTrS1dutKKCMB252ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208130001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xMS8yMDIyLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+IE9uIDgvMTEvMjAyMiwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPj4gT24gOC8xMS8yMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+Pj4N
Cj4+Pg0KPj4+IE9uIDgvOS8yMDIyIDY6MDggUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+DQo+
PiA8c25pcD4NCj4+DQo+Pg0KPj4+PiBUbyBzdW1tYXJpemUgdGhlIHBvaW50czoNCj4+Pj4NCj4+
Pj4gMSkgVGhlIGhvc3Qgb25seSBhcm1zIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAgaWYgdGhlIGRl
dmljZSBpcyBjYXBhYmxlIG9mDQo+Pj4+IHJlbW90ZSB3YWtldXAgKGNoZWNrIFVTQl9DT05GSUdf
QVRUX1dBS0VVUCBpbiBibUF0dHJpYnV0ZXMgYW5kIGhhcmR3YXJlDQo+Pj4+IGNhcGFiaWxpdHkp
DQo+Pj4+DQo+Pj4+IDIpIElmIHRoZSBkZXZpY2UgaXMgaW4gc3VzcGVuZCwgdGhlIGRldmljZSBj
YW4gZG8gcmVtb3RlIHdha2V1cCAodGhyb3VnaA0KPj4+PiBMRlBTIGhhbmRzaGFrZSkgaWYgdGhl
IGZ1bmN0aW9uIGlzIGFybWVkIGZvciByZW1vdGUgd2FrZXVwICh0aHJvdWdoDQo+Pj4+IFNFVF9G
RUFUVVJFKEZVTkNfU1VTUEVORCkpLg0KPj4+Pg0KPj4+PiAzKSBJZiB0aGUgbGluayB0cmFuc2l0
aW9ucyB0byBVMCBhZnRlciB0aGUgZGV2aWNlIHRyaWdnZXJpbmcgYSByZW1vdGUNCj4+Pj4gd2Fr
ZXVwLCB0aGUgZGV2aWNlIHdpbGwgYWxzbyBzZW5kIGRldmljZSBub3RpZmljYXRpb24gZnVuY3Rp
b24gd2FrZSBmb3INCj4+Pj4gYWxsIHRoZSBpbnRlcmZhY2VzIGFybWVkIHdpdGggcmVtb3RlIHdh
a2V1cC4NCj4+Pj4NCj4+Pj4gNCkgSWYgdGhlIGRldmljZSBpcyBub3QgaW4gc3VzcGVuZCwgdGhl
IGRldmljZSBjYW4gc2VuZCBkZXZpY2UNCj4+Pj4gbm90aWZpY2F0aW9uIGZ1bmN0aW9uIHdha2Ug
aWYgaXQncyBpbiBVMC4NCj4+Pj4NCj4+Pj4NCj4+Pj4gTm93LCByZW1vdGUgd2FrZXVwIGFuZCBm
dW5jdGlvbiB3YWtlIGRldmljZSBub3RpZmljYXRpb24gYXJlIDIgc2VwYXJhdGUNCj4+Pj4gb3Bl
cmF0aW9ucy4gV2UgaGF2ZSB0aGUgdXNiX2dhZGdldF9vcHMtPndha2V1cCgpIGZvciByZW1vdGUg
d2FrZXVwLiBJDQo+Pj4+IHN1Z2dlc3RlZCB0byBtYXliZSBhZGQgdXNiX2dhZGdldF9vcHMtPnNl
bmRfd2FrZXVwX25vdGlmaWNhdGlvbihnYWRnZXQsDQo+Pj4+IGludGZfaWQpIGZvciB0aGUgZGV2
aWNlIG5vdGlmaWNhdGlvbi4gV2hhdCB5b3UgZGlkIHdhcyBjb21iaW5pbmcgYm90aA0KPj4+PiBv
cGVyYXRpb25zIGluIHVzYl9nYWRnZXRfb3BzLT5mdW5jX3dha2V1cCgpLiBUaGF0IG1heSBvbmx5
IHdvcmsgZm9yDQo+Pj4+IHBvaW50IDQpIChhc3N1bWluZyB5b3UgZml4IHRoZSBVMCBjaGVjayks
IGJ1dCBub3QgcG9pbnQgMykuDQo+Pj4NCj4+PiBUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2sg
YW5kIHN1bW1hcnkuIEkgd2lsbCByZW5hbWUgZnVuY193YWtldXAgdG8NCj4+PiBzZW5kX3dha2V1
cF9ub3RpZmljYXRpb24gdG8gYmV0dGVyIGFsaWduIHdpdGggdGhlIGFwcHJvYWNoLiBUaGUgcmVh
c29uIEkNCj4+PiBoYXZlIGNvbWJpbmVkIHJlbW90ZV93YWtldXAgYW5kIGZ1bmN0aW9uIHdha2Ug
bm90aWZpY2F0aW9uIGluDQo+Pj4gdXNiX2dhZGdldF9vcHMtPmZ1bmNfd2FrZXVwKCkgaXMgYmVj
YXVzZSBzaW5jZSB0aGUgaW1wbGVtZW50YXRpb24gaXMgYXQNCj4+PiBmdW5jdGlvbi9jb21wb3Np
dGUgbGV2ZWwgaXQgaGFzIG5vIGtub3dsZWRnZSBvbiB0aGUgbGluayBzdGF0ZS4gU28gSQ0KPj4+
IGhhdmUgZGVsZWdhdGVkIHRoYXQgdGFzayB0byBjb250cm9sbGVyIGRyaXZlciB0byBoYW5kbGUg
dGhlIG5vdGlmaWNhdGlvbg0KPj4+IGFjY29yZGluZ2x5LiBUaGF0IGlzIGRvIGEgTEZQUyBoYW5k
c2hha2UgZmlyc3QgaWYgdGhlIGRldmljZSBpcw0KPj4+IHN1c3BlbmRlZCBhbmQgdGhlbiBzZW5k
IG5vdGlmaWNhdGlvbiAoZXhwbGFpbmVkIGJlbG93KS4gQnV0IHdlIGNhbg0KPj4+IGRlZmluaXRl
bHkgc2VwYXJhdGUgdGhpcyBieSBhZGRpbmcgYW4gYWRkaXRpb25hbCBmbGFnIGluIHRoZSBjb21w
b3NpdGUNCj4+PiBsYXllciB0byBzZXQgdGhlIGxpbmsgc3RhdGUgYmFzZWQgb24gdGhlIGdhZGdl
dCBzdXNwZW5kIGNhbGxiYWNrIGNhbGxlZA0KPj4+IHdoZW4gVTMgU1VTUEVORCBpbnRlcnJ1cHQg
aXMgcmVjZWl2ZWQuIExldCBtZSBrbm93IGlmIHlvdSBmZWVsDQo+Pj4gc2VwYXJhdGluZyB0aGUg
dHdvIGlzIGEgYmV0dGVyIGFwcHJvYWNoLg0KPj4+DQo+Pg0KPj4gVGhlIHJlYXNvbiBJIHRoaW5r
IHdlIG5lZWQgdG8gc2VwYXJhdGUgaXQgaXMgYmVjYXVzZSBvZiBwb2ludCAzLiBBcyBJDQo+PiBu
b3RlIGVhcmxpZXIsIHRoZSBzcGVjIHN0YXRlcyB0aGF0ICJJZiByZW1vdGUgd2FrZSBldmVudCBv
Y2N1cnMgaW4NCj4+IG11bHRpcGxlIGZ1bmN0aW9ucywgZWFjaCBmdW5jdGlvbiBzaGFsbCBzZW5k
IGEgRnVuY3Rpb24gV2FrZSBOb3RpZmljYXRpb24uIg0KPj4NCj4+IEJ1dCBpZiB0aGVyZSdzIG5v
IHJlbW90ZSB3YWtlIGV2ZW50LCBhbmQgdGhlIGhvc3QgYnJvdWdodCB0aGUgZGV2aWNlIHVwDQo+
PiBpbnN0ZWFkLCB0aGVuIHRoZSBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGlzIHJldGFpbmVkLg0K
Pj4NCj4+IElmIHdlIHNlcGFyYXRlIHRoZXNlIDIgb3BlcmF0aW9ucywgdGhlIGNhbGxlciBjYW4g
Y2hlY2sgd2hldGhlciB0aGUNCj4+IG9wZXJhdGlvbiB3ZW50IHRocm91Z2ggcHJvcGVybHkuIEZv
ciBleGFtcGxlLCBpZiB0aGUgd2FrZXVwKCkgaXMNCj4+IGluaXRpYXRlZCBwcm9wZXJseSwgYnV0
IHRoZSBmdW5jdGlvbiB3YWtlIGRldmljZSBub3RpZmljYXRpb24gZGlkbid0IGdvDQo+PiB0aHJv
dWdoLiBXZSB3b3VsZCBvbmx5IG5lZWQgdG8gcmVzZW5kIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9u
IHJhdGhlcg0KPj4gdGhhbiBpbml0aWF0ZSByZW1vdGUgd2FrZXVwIGFnYWluLg0KPiANCj4gSWYg
d2UgZG9uJ3QgaGF2ZSB0byBzZW5kIGRldmljZSBub3RpZmljYXRpb24gZm9yIG90aGVyIGludGVy
ZmFjZXMsIHdlDQo+IGNhbiBjb21iaW5lIHRoZSBvcGVyYXRpb25zIGhlcmUgYXMgeW91IGRpZC4N
Cj4gDQoNCkkgc3RpbGwgdGhpbmsgaXQncyBiZXR0ZXIgdG8gc3BsaXQgdXAgdGhlIG9wZXJhdGlv
bnMuIFRoZSB3YXkgeW91J3JlDQpoYW5kbGluZyBpdCBub3cgaXMgbm90IGNsZWFyLg0KDQpJZiB0
aGUgZnVuY19hd2FrZSgpIHJldHVybnMgLUVBR0FJTiwgSSdkIGV4cGVjdCB0aGF0IHRoZSByZW1v
dGUgd2FrZSBkaWQNCm5vdCBnbyB0aHJvdWdoIGFuZCBleHBlY3QgdXNlciB0byByZXRyeSBhZ2Fp
bi4gQnV0IGhlcmUgaXQgZG9lcyBpbml0aWF0ZQ0KcmVtb3RlIHdha2UsIGJ1dCBpdCBqdXN0IGRv
ZXMgbm90IHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiB5ZXQuIFRoaXMgaXMNCmNvbmZ1c2luZy4N
Cg0KQWxzbywgaW5zdGVhZCBvZiBhbGwgdGhlIGZ1bmN0aW9uIHdha2UgaGFuZGxpbmcgY29taW5n
IGZyb20gdGhlIGZ1bmN0aW9uDQpkcml2ZXIsIG5vdyB3ZSBkZXBlbmQgb24gdGhlIGNvbnRyb2xs
ZXIgZHJpdmVyIHRvIGNhbGwgZnVuY3Rpb24gcmVzdW1lKCkNCm9uIHN0YXRlIGNoYW5nZSB0byBV
MCwgd2hpY2ggd2lsbCB0cmlnZ2VyIGRldmljZSBub3RpZmljYXRpb24uIFdoYXQNCmhhcHBlbiBp
ZiBpdCBkb2Vzbid0IGNhbGwgcmVzdW1lKCkuIFRoZXJlJ3MgdG9vIG1hbnkgZGVwZW5kZW5jaWVz
IGFuZCBpdA0Kc2VlbXMgZnJhZ2lsZS4NCg0KSSB0aGluayBhbGwgdGhpcyBjYW4gYmUgaGFuZGxl
ZCBpbiB0aGUgZnVuY3Rpb24gZHJpdmVyLiBZb3UgY2FuIGZpeCB0aGUNCmR3YzMgd2FrZXVwKCkg
YW5kIHBvbGwgZm9yIFUwL09OIHN0YXRlIHJhdGhlciB0aGFuIFJFQ09WRVJZIHN0YXRlLCB3aGlj
aA0KaXMgd2hhdCBpdCdzIHN1cHBvc2VkIHRvIHBvbGwuIE9uIHVzYl9nYWRnZXRfd2FrZXVwKCkg
cmV0dXJucw0Kc3VjY2Vzc2Z1bCwgd2UnZCBleHBlY3QgdGhlIGRldmljZSBpcyBsaW5rZWQgdXAg
YW5kIHdva2VuIHVwLiB0aGVuIHlvdQ0KY2FuIHNlbmQgZGV2aWNlIG5vdGlmaWNhdGlvbiB0aHJv
dWdoIGEgZGlmZmVyZW50IGFwaSBzdWNoIGFzDQp1c2JfZ2FkZ2V0X3NlbmRfd2FrZV9ub3RpZmlj
YXRpb24oKS4NCg0KVGhhbmtzLA0KVGhpbmgNCg==
