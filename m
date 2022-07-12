Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98A571541
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGLJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGLJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:02:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66E8AB2C;
        Tue, 12 Jul 2022 02:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5DizK6dYNr86Uzs5L64Vu6hc94i+Jb8I776IlGtcsHKvO0uXbpmZu043IGvtauoNKhe+v8UhAvdiKzxq/SKas3ifrnCODJHETTP8iLd6Haww347vcYpJrWjHo3hjUwlleLlNCxZEI/5awZ58zjtu4omouTS+0SMl/5owMo3tvh3aexBOJ/DuPhhChC/uLjlZ9aEP6c5+d8yyvAjQRrB3AfmQ1pn+dpBh0FOi0dydghP90MMcXYWKulOCx9kugfA797NK3PNuGOYPMQGRNYe1atXb9Rtbcnr1usVyQ3MLRbfhAMJZ8FilHx+r8GcGuHwX5KFlyM7w+2k8XsiJxZdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rsedrOrIy4+HWeo5McQrKx1rodxT/5/qy1BK+JsV0E=;
 b=DD4ipguCG1627eGn+Xr/DlSw4uBBC51w9R9CSizqWTcl7ntvhQ+ow1GfVEjuPyJtQ3xA8VIP3yG6FtVm6fxzqt6ygx9mo5gFffghCzmzmsc2DL7QwO/X4qGM4RniLjzVAqsDdEptxd9T/kTovkrVoIZaXnzQRTA3Q+anlWOrvY+lnZN58rP+Zkk8k6q2TyoGBymufqOXv+9MuM6SSXglhdauQ7V1a97DAfjeA92PUhVvihDn8Nr5ScE3bMxTKPjrepnNQeSELR3vmyMy4AjhjV/FftN9Mud554Vusvev5ZQI/acCsMY8jlzEtNnD/T9VLVLijkluy5ivzqpGBpJJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rsedrOrIy4+HWeo5McQrKx1rodxT/5/qy1BK+JsV0E=;
 b=vQBDXSFsWTdKD8sNF37OkD72tMtIWBkSDt6/09pZtc5Q/XgDdS/dPcwPgkPaRywxEFgRG/B8CjInjEFEzr5LJFoGMcOH4C8OKn2UtoChGS6OKhdd0j4qg8CY+45aet0sLE4b6bEoUsHlc6MwHo86bgo6d9oTInMXsCbmtBn5yXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN6PR04MB0658.namprd04.prod.outlook.com (2603:10b6:404:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 09:02:22 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:02:22 +0000
Date:   Tue, 12 Jul 2022 17:02:17 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v15 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220712090217.GA2783292@anxtwsw-Precision-3640-Tower>
References: <20220712064111.2782861-1-xji@analogixsemi.com>
 <20220712064111.2782861-3-xji@analogixsemi.com>
 <Ys0xdDVzO2czw6mh@kuha.fi.intel.com>
 <Ys01rHaCvXTjqKu/@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys01rHaCvXTjqKu/@kroah.com>
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd58e69-2d9a-4d53-972b-08da63e53b76
X-MS-TrafficTypeDiagnostic: BN6PR04MB0658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpa14gLhIrG5hSoFeSMszGiwgxLLg0+QKkrIPfvn3U0xjxf0p6vOrvaILKrMYwXAaKzIXPg1HHcTBPFeJ8S9dQZUG0DNf8W+huEpZ/yufo6LhiduJW/dNPe10ZMtCMyeAJY4M7++lG/aEdAmG0Xh9pbV9goJmsXCXvJEqmQEjIUt6uRAuMOg/sffLT1/cczmOAjY5Qz8BzUY1C0XzBa5qBkxWhNSv0OZujXmJQR5V1+ZZpNZTWKQo3lqg+aqZ5dbuTOU3/69OqertW+CJz4JZvZa8in/+lAlZs1s2P3WfGj7s1GLiHWHZXXaxp/IQCokWhseiWx7E3BWzeYpY4PjYOoo7gDWXyjQQg8iyv+gcX+MG8i2k7BTs8l7aKNl6AQdadfY07iITFcHCqht87PiItgsKcnZMtVsQb0YazfUBN2/di4PIHDIBwWHl8hjBaj+H5Lmv5WmwVx5KYPCRFa83Lu1g2iokzgR+XBnFUCWpep+HIen4jRn+kUpjCETFVoeNBlnJDDofj5Acrb5DxV9Duxx3O6cZuCaybaRvtgQqKJSuUJdBfCTy2NqH+pFnFYpk6y268xrBphpZVTFfiDJksxW5aj/d5HD6TpAjwtzPX/6qejYl3UcmW1dzcN1MKfWywqIngNwyzDMbe/I10TzncyWL8OitZ6VUJ6I0pJlWiDubFol0WBc/TxrA1drGYDYkDYSRdZR8zIuRwLNKvIKmo6DFsfliEcUvIgYYQty9D+CoQsir227q76GoNU7soueYYXHE7oh/SUFDyaYsSYuuEn7i4i0vCAFJkSunp/oAP7yChSEqNGygRSiXij8hvMj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39840400004)(376002)(396003)(136003)(366004)(4326008)(66476007)(66556008)(38350700002)(8676002)(6506007)(66946007)(186003)(8936002)(52116002)(6666004)(26005)(41300700001)(6512007)(9686003)(55236004)(6486002)(38100700002)(316002)(1076003)(478600001)(4744005)(2906002)(86362001)(33656002)(54906003)(6916009)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EbuAvwFQFVuhUomEUOqnq0ZnqTP/8eoipD0aUUqJBYcNQdZMGEx8GvuZEEIG?=
 =?us-ascii?Q?gtRxILyccsLolsg5DDCPMlXhyygzf5zgjY5MYY0pHPycq38DQEQaXEMF1aYW?=
 =?us-ascii?Q?VjItbgCu4Tct0s9mt+itBo0nVrhan5a3Ly0ZOOv+1p0xgOAgr6rdDx/1Yr/Y?=
 =?us-ascii?Q?Initw8DIz087mPp44nXpHfI7+8k/3ZWpqZNgtKF+gusUe4rp8VIqWsfFQVOY?=
 =?us-ascii?Q?9SgV0hpGebF7UAewtzfMrvUXk/ddcuWR5SBbUogJJ2e4r6AFfDQGFrWWEAlP?=
 =?us-ascii?Q?azWTQL4T1AKAxokc3U6uUm30gT4GoGONLqTjmN6NFRAWy+murvCZDwlzGQ+0?=
 =?us-ascii?Q?E6nRVcvEslflNLzzhuFCCvVQ5eb6j7JHvmvtdqjc4ikZ4Vgx7eJaxLnzR25M?=
 =?us-ascii?Q?ykxSB5Nxr64ZPieFh16Xf4yUotmCELur44X87d7oT17AkYmPkUDehNMN+4MA?=
 =?us-ascii?Q?HGJREyPUlTvwCFpybC7QxNacN8YjVKJ3JtgL/bxCLDDuvtQPKPaC9ogDMUPk?=
 =?us-ascii?Q?A6oH12vpXB3c7jlYcELfmZVkiy0dhDW34SUwtXTDu200762/o2iqtOMICadq?=
 =?us-ascii?Q?k41Ow80lIAs6Zkm9fQmdR/rIfxfXKtk+JMeKMbqtUl4T9DenSLiQFUKdvW7p?=
 =?us-ascii?Q?akwfzoTCvCunZGq4LFdbP4haeyLzkMKMp0VLK55ZaCbWHA3QdkR+yrsh15Dk?=
 =?us-ascii?Q?RmF5ld2l3dPKBAybSvgw+5qtKI086GvVjCBuVULe+NLc4n1J582pQxU2yUa7?=
 =?us-ascii?Q?W4v1HOHWzn4FiFz0L6HsbN5fvKTnZoflKc06D6qrGPtmpqY2km+7WkxGU5NM?=
 =?us-ascii?Q?5flko8BTo1wu3zIY44El+BSlEsOFRP858uAI+YSnFyojMm9ggFkrS2AXvfNK?=
 =?us-ascii?Q?VIfwjRZsw3NUtL6YlBnPaxH5WmvpVRBbI8SZ2hkNCT9n7FDxu4qkZnT2nJVb?=
 =?us-ascii?Q?7t2jAi3FOHcFoDPi1vKqtH2IHx7RPovpMprJC90SrimFc2ttlxFvSA6NttQj?=
 =?us-ascii?Q?nZAr9r4vcapJH4VVQhdu+mfPnKwAKMpnmswZaQ5eGy1VFZlmDe5zv2o4+jt0?=
 =?us-ascii?Q?0QJkKzipoLb1YfaJLkBozYEB78wNNhgugbBXC0Ux9Dve8NeUc+0xIcO1ktRK?=
 =?us-ascii?Q?q3td3kpT1YTovMrxzcL/txohQeFk6pvLtw2Yzt6QZF7m6+Yb/Een8ru01E5g?=
 =?us-ascii?Q?1rgbUk20UuXzQXbh2pN/Bu/OFjRosAcFJ0C8aHMAilxyxNMRtsH8Opu43/DS?=
 =?us-ascii?Q?0DaP4w5wEqAlTmhjwlB6VuXToxGm0Trypr88zptFs9UMVLv0z4s+8F2+1zWR?=
 =?us-ascii?Q?tSPAIT2DrQz79OXJ5U63W3f5hkVVVvKnHTq/hLfud7LpJTd+ftVxY4lCvJ7J?=
 =?us-ascii?Q?3YyWCra3CFxrmNfbj7mM6bBmQXpOrtjUF1RRRA1e0NTXecqXIpm8iQ7safB6?=
 =?us-ascii?Q?thWGjOBp4Qsr+MK9g4fWJnTMl6XMQe6nDSXiHl21QQ+hO6yc2QjXgEFwt6Ka?=
 =?us-ascii?Q?ZBboscycfbyN7fOx/c4Flc6LcbQiXiq0WqRdo9YhupRVSHHDb8ETCNSWGGHv?=
 =?us-ascii?Q?1FNjkiInHdL3DeabQrGLCdJyQZ9+nXn5EeryHM8m?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd58e69-2d9a-4d53-972b-08da63e53b76
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:02:22.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGlzJ1x00aAY/EVZVMzhBtpmiWfvtuDCUgj06VZ2k8E+YJPIF2RXETxSQW5su1mSxgVXLjnQXRxHzBb2uKm8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:49:48AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 12, 2022 at 11:31:48AM +0300, Heikki Krogerus wrote:
> > Tue, Jul 12, 2022 at 02:41:11PM +0800, Xin Ji kirjoitti:
> > > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > As this is a new driver, I'm not sure that Reported-by tag is
> > appropriate. At least it's a bit confusing. In any case:
> 
> It's very confusing and wrong and needs to be removed before I can take
> it :(
OK, I'll remove it and resend it
