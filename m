Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4BC572EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiGMHUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:20:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2F7391B;
        Wed, 13 Jul 2022 00:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5zYbpXuvMajuypvdFzaHlEmxL+7ZzYvJGbuEbaWBcln7H2AWRMcYHcm73XSJlxzaTUiwadnOMqR7ikPhl7iIrFxc7asTNsYArfPD1IPmraBKf743oOsUJB0riX7HW4sbGWHHhAnU6S3mlR0P1VDZEaRIgmQqvUU98M8DwlDKeYm1RzY/RObW8yM0BcIe1IcDb9CGvRJERkSdHZYMxpqEHWqYnUTGYfc4uoTBcUIqO3++IKUdGy8agnDMIVz2+bIlhtsJ2et8wsNlsOO08NdbEHN88HAc+gUL9qGboPzNO5nPYmQPa0k+SMeP9gSziLuDmtx7GpkXkj0FVXBbTiyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEXMr6HZ+r+igrCK+9V5nMmN7rMtstnaioWad/Rsq7o=;
 b=eEMSKyXwgRvkRSllGeUPkK4WvGIlf0W36jBx2n29OfgtVLOkEpsbLvWhhH7Ap+PNmD9HNQOR+eprYvkUjESNp4wVoiwSDBZgffkJJGu0WO7SV62YlqvHfEdJNz9l3WPLsxHZksVbrI9JU20Upb4SW4zAvtSOOsBash0jT1ax6OtV3U1htCEzvGHL4YvEs/g4JNfoGwnPjFMDim7hv7hlw0DvHKg1uxTOZYLZ/gjLrsOp0ml322fz8r659eB8xCG/khaNhPr3OQqxl83QYmkw9JzI2JkEXWdjE5VQXvSRe0E1TRfiReXo5cYXqUYiHu2jRTknqvIwSoGtwVqYGseztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEXMr6HZ+r+igrCK+9V5nMmN7rMtstnaioWad/Rsq7o=;
 b=eqbNeG+H+uxdftk3rGIJD5OpRmE+ZHbe1E1sjmJ2Bxwtj1YHujq1U/sggexXapqxVClf5LJmvucv+k26Qloc8Z2/HcNf1q5QycDzlArxIxksmC+2DOJJv7ZYlmHlmlIrFfWx1GvY/SDZEyg/NRsD31y+hhCqPkYdAgr++4wR/BPnJNHkWPi3k2mlE/t/q+DZAe4HKTPw1yA+wU5AcDRkTbphlnGk6it6l3Wu7RENP5kwZkgwH7hZxIOpuMgfvbgYJdL2UaKeGFxJpIaw9Bp592oniu9oa4Vj5nwdQP7fJN2A02k3mxqAN/H7SzJ5WGp3tM5OL1uswNdg+oagm+MX+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 07:20:30 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::253b:4d66:1a99:f6e0%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:20:30 +0000
Date:   Wed, 13 Jul 2022 09:20:27 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
Subject: Re: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
Message-ID: <20220713092027.56a60f1d@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VdyTRTwFBc3=RL4VHy6VW3zGwijsQM5W47vfqZWxbko2Q@mail.gmail.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
        <CAHp75VeYHi8XTf3Y6HMmitVvuvF2uiWdSzpiKFji5SfV20HqpQ@mail.gmail.com>
        <20220712171602.1e7c49f4@md1za8fc.ad001.siemens.net>
        <CAHp75VdyTRTwFBc3=RL4VHy6VW3zGwijsQM5W47vfqZWxbko2Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::30) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0522cff1-d5ee-4782-b1b2-08da64a02a90
X-MS-TrafficTypeDiagnostic: PRAPR10MB5422:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKQfum+O0TxRfKGjMZ63voVjM+eQ/KTMT4t1rEdH3eg5X42tbDcXH4cvlkKQCi1IUJynRsf4+iIpaquFcj/EdOsUTC4UhkOpOMJ6uHpeR00yqK3iN54IB8DiNYMzIH40CkTusTXYs8ZXpDBa68vkfw2bpkoawEVucmGZE6+mR8r/HloBO/sbaDIOMU2+5TCoGl1NvtDQuzzEj0pQHF6yCKXuz1gn6YgSAs209A59gF0etEvY8Y308XttYa8sWc4CYpTdy/GydhVMvpPahjEaw7H0h514iVngsGxkHgHNBs1zxIiqoRTqkxEOhQ07QB0D+uoJ3xofwQSr4bAzAgN4lFlKa/Di6aq4+c3KBUk4zlFaIhaVsm2011UPK9bDjFHAL6ARGIi97Mtsoj9ikMQfPQAesUf3fPfgC347kl0DU0iMZ/NDks2APF/CXvvXpZwR4Mvt3F75xym3/AewPM79ptB1UN0K0yZiW3d3GDW/46AvM2uDCKuf8vbzLrs1N3MKul2Tqmb49Tkk9/l++LP4vVmuerWmoq5QSMINOjCE+DRK0DJKop8gTcfnyGDhv33KknV4+rQGq7KFruTksCJB3dJgJLm8Ep566SyhVRVKI6JxlW9LDwDMG2p6o+dlPyDN2tJqKDloDucsIi0LjQ6BAUC7AjO75kJBFDJSW/YiupV9SiKetg+wgjG7aKNVGUVggjd/4lCdYxIHxwWeJbfAbA+1yZR07KakLO8e9N17f0Ckbb7Mz2wmrIDyMElx0Lk/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(6666004)(316002)(6506007)(6486002)(53546011)(6916009)(41300700001)(54906003)(66476007)(2906002)(478600001)(8676002)(4326008)(66946007)(66556008)(8936002)(44832011)(5660300002)(4744005)(26005)(82960400001)(9686003)(86362001)(1076003)(6512007)(83380400001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSvJDd4+8EApxI5HQUFiu0OjbyanuVHhOofVOo2IkaaiKcNIQs0M3NZyWT9A?=
 =?us-ascii?Q?6fGh0AGU4RJfV3fxPMMyMh1mjgiHLBVPNobe9VJElRtyjykaEt6v925USXUm?=
 =?us-ascii?Q?ZUF14s2Zucs41XtblYASATm3UdVthMbQv/pRtO+AP35I+VC4pkeEVzgAWlav?=
 =?us-ascii?Q?+ztuKBlLmCTUrTKoUwFz2uisNS95f4pDfPdTB1apHjidAH6mv2ksv6D/ziS3?=
 =?us-ascii?Q?5H8d2+1tXdWCfMoYQiWgsjnS640ZeeLUDdwVOYDIAAWzkDCcPBlgHAe/K8hf?=
 =?us-ascii?Q?snFo9yGTXLzuIFM8ujYsx/YQZrFeLHds9ijfa9N0h7l4iISDNCEumTORxw3R?=
 =?us-ascii?Q?VR7C3dBSNFJC792dZ9D68PVFa29jPh+xB3KuKCrpHezh7WLg/rhfZ1jqHalz?=
 =?us-ascii?Q?cFyvgOVAxBdVCMCd6eqImaGRw9KVpEIpsfPMy43gBow/ovaoA3zx7t1NDI+g?=
 =?us-ascii?Q?jxi9Plk/TZQmIfr0zLpTqKYE+p733YIpVYpXiXNHD1LiqmPerOU7/xeXCBcP?=
 =?us-ascii?Q?aNSe3LfDD3og0+WUMJVBOoNnXAlsfihyFh/RV4bJ6BWqgAvnYvULSGVvPdUo?=
 =?us-ascii?Q?mseqXq1LsF8F7LorL9Bgx53R/wbpd6t25OXgOtJTt+7kQCuVGdlqpkyEtMJZ?=
 =?us-ascii?Q?7MA3NbqRpQ//9OiwLgZ2I2tFWTftuwQ7FEYjk8abNtPjlPyCguDwl1eP8gVN?=
 =?us-ascii?Q?hCxmT9vdAWgZxJuRdkgDPJd9gLxGKB1sK4rjo7WwjB7rSwbYBRJsHg+1LSuC?=
 =?us-ascii?Q?LPnUzKcmWc8CN1WMqs1LyE6pq+b36CSEf8/B0Dbb2lM058BFAdF1g9cFW+is?=
 =?us-ascii?Q?27CscoXbAN/kFCwzkfyp6dFl3wPqJkeUluqp0CVqjrL8Ivh0DNZCOXwINrWV?=
 =?us-ascii?Q?BKt4UOQy325gtl9Bb+fwnOA38OmYzq0JTKq6m693czVcYYX9ydbNaSRahN2B?=
 =?us-ascii?Q?m4fhA4sd6FWFStqzx2l1auZpYIjk6TTQeHvgyZknQVqbcyt8Gpw91yafRM0l?=
 =?us-ascii?Q?txK+eyx89URlukuGZb+GwdLKFCYQBBfVvq15eWbxUZlcMtKZuGkgnOz7pAj+?=
 =?us-ascii?Q?cm0HtmdJQ/5Jz/3Go3sD/WN91OWYLW/tXYfYFPU/B/uwRTyX1CpH4vDzIsLO?=
 =?us-ascii?Q?qe5pzePbX97EMv6zgOXNiTX3FE2Ph9g3JvX2Cwm9j4KLjmczdGM93YLJKsmS?=
 =?us-ascii?Q?DnL/+T5NPLRJe5SIOQgL/hweFgg69Jn5FPz+OECKjxiqWuIUzyXbxv0rkbjm?=
 =?us-ascii?Q?qTc62rXzCwJ0pg5RC8I7U6GgPlQb/GDZeNxFj++6CYf/cTuuw1ve00HkwtiD?=
 =?us-ascii?Q?81PC7DAQEhw1j8y92aqnSCzQoDu6HPfrM2c031b6vWSOKg8u+dBoFW9hWKFk?=
 =?us-ascii?Q?SB1o7ovQjfBekkc9ollXM+eaGaRAAuWH6f0VlaKsPS/kxNGSjmIFBJla1ZWT?=
 =?us-ascii?Q?FIiY3VSPaifFMQXdJMWnS6fyO+AhZmNg3E4xwx7fu0/OA8fEc195UpZ8UhGK?=
 =?us-ascii?Q?qX0JIdcDc7chefCcQ2slExqTd4u5xZrr+nJ1JF806Cs17is3kz7WdGOIn0AB?=
 =?us-ascii?Q?QxW7TbSzBBeovIoOAGUbTMVaIZf2lRA4mhv09EDXa3+yHnVOiQ1ovSBq85js?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0522cff1-d5ee-4782-b1b2-08da64a02a90
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:20:29.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGEIxzf+r7t/VfMWmnK+ZBB43s9qfcuD8z86vGv3Mtjaj7UipYL0Fxxb2Ft8RUJbBYrXvIddOLcSbqoXSxB9b83gx23fH0U/LBIdU/KTTwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 12 Jul 2022 17:22:45 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Tue, Jul 12, 2022 at 5:16 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > Am Tue, 12 Jul 2022 16:42:46 +0200
> > schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:  
> > > On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
> > > <henning.schild@siemens.com> wrote:  
> 
> > > JFYI: You have a strange subject. Had you used `git format-patch
> > > --cover-letter ...`?  
> >
> > Yes, but i changed that subject. Took the old line and turned v2
> > into v3. What is strange about it?  
> 
> The 0/1 while it has to be 0/3.

A right, copy/paste mistake.

Henning
