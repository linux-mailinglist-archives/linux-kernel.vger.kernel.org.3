Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716F58D27D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiHIDtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiHIDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:48:17 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 20:48:09 PDT
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677B1EC77;
        Mon,  8 Aug 2022 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1660016889; x=1691552889;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oRzInEJHBY9A1tG1idbV/nkvUBlv+6iWZ57uIjLDxDM=;
  b=NLMU8n87VIyvEtDOuJbav6X0Df++j0r7CaWPfKS5KMaQf/BE0Zp0iIO5
   WFQbREVTZudPK7hQ91yYCUG5POKVpKv/eDbbVwZVhbb3MbFaaDZuIZG8v
   aH3OQsyp3wiTShOcACkbxOJVvLXVVpBhsCvNCuH0lSJyV3Z/neujIDGAu
   s=;
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvPZ8JHdy+rFIM9G4QspGsKiBCNu7YhtWG7xsTSROUVv5vk05My4hdZj855wj5XKhERzX6RsdRTE6aC36+QCvVcqKaJ3Cl7Hhm3zbEPCOYfZdkJvBwVVaZpZK7PTXcKOHFQrNBv400d1GmfHJrhQg3j8NcsXpt/B0axFphC5lW55QNkwzDBxMcM/rIa9Tr6e2c7Rjh6NKPHoWL8BZHPnZiLjhbSnQfHgcwbm5uZWLKko2S6MVs0LwDGELOrtbyHVGvoKd1Mw5nobN9tCw5pUYTOBn079eza4nG5WbaSQ3vPkdTaciClgzfpmDmsZGaeJRz0Nr7Wfe0PDXA0k7Bv/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa9orex2hmMVddERZRopR5jjR8G70vTO4hJsdyz8mcA=;
 b=f068mPPx8x5hic7APalb7DyyuJHUZaMUyp+zcQ2nUEoXdANTm0XXxqzNUcwc/3IyFgcg5/U15BGeLRzt8u4WaDmNqa39pYGIoETjSYxl1KuyxpL0SvB7AJsmgORA8MuFS1k7vJc2HABxQXOn0ydGkY4Nl5STwmn9Qsjw56vu+OzlMGMG+ierC3+ZuqeugM5CpVYLikoGGnQDuh2373Tpe/aU4C9BSQRMhFEpgKPX3nTVhrSchThoCbEUUcjwVf0ErvUhHzIf9ZxrYb+sGjRoQqgFufDE/PDtarlMi1cFJun3TMJS4mJevN39FnW2zKwI3/4x5VC/DwxPrnqB7WLeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa9orex2hmMVddERZRopR5jjR8G70vTO4hJsdyz8mcA=;
 b=V0CPaI/N/C0lNQKQysb993Xba0ulN+1+O2JCrTBMFVbWIn6exqiHODuJX4X8bQZKKFMFzeTDGwos3v6amAtFbfYW3GwqhoMClmWHt15Q2JRtDRV8oOf/bXPxSW2iNIHH5o8/Ac/S/9sNOxxqi/+wDQ1Cu6VhZr212NUOxrgpA3o=
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com (2603:10b6:a03:42c::20)
 by PH0PR20MB4494.namprd20.prod.outlook.com (2603:10b6:510:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 03:47:03 +0000
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::b456:9aa0:e357:31f5]) by SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::b456:9aa0:e357:31f5%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 03:47:03 +0000
From:   Rory Chen <rory.c.chen@seagate.com>
To:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuQ=
Date:   Tue, 9 Aug 2022 03:47:03 +0000
Message-ID: <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
In-Reply-To: <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-08-09T03:47:02.803Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d44d8958-db5d-43f0-68f1-08da79b9d276
x-ms-traffictypediagnostic: PH0PR20MB4494:EE_
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hE5r952BSFs1zOfw1hYvTtdDHbcwfELmKHsLk5dh2OIvXMUkHpEW5oqkrQFHaIWxZPBPBPuHO2wEEiUm7dEbWAZsX0ZPE/OjuuifDtU5SgUPcm/uUQKQko+fqnCC52D65jqJW4lveAw507bXGWBN/JkFmbU0raBjhcTQuzi8P5fQSpmYdGHTdQM6g/e9u5+cCKeubEboXpAUNtfmUKXOzhSAEXRviV36k5xCkPsBoD3CGGXJaeNX6jciNMMs7Quj2+fiTQTrhLsiwLJhQzE3e331maZ+RkdOVdGt7OF4q25jZ4l56ntrjQDNRk3F+MO/nZM3D0VDjqqVXmfrOhoKHNtwUbjncbEI33guYDh2kDEXORcEKcJIJ8f4+Zk3pY/DSmnE3A6M2qAsjRWSTd1f1SNN4bWrQpH7F9ydwjVfbtEDUcU1WLpfaQRc1um1TkOPLTm+Ua073QuiiphwKMIAx5Tt6C8eg8aKDh4hwvL8Q1GgJJmaA6rd0IqnED4cacJ9eLfluJU79fFbehCMVahlGaucrp32s+EK8bcrdw8DqYi9Fwr79/g2h0u4ieNAN0s1nvZwpg/mwnxvc2/qreFp7HQfnv0PPaWzvwmKJllFLVOz6JBAyW+Kk9hSBqItq6jy/l8jmrYpqD43xI6C0PUQ3ZzrsOHrb5uwThxKpShhiKfNDZh4Jsf0y1B4zIIjX659ye/PsYnsW36nKpWl6cjUDqYO8PLAeFtYL24KyGZgAQQpZBEHJ1oxdPs5Wh3K0Tx1mVv6+L0IwD33cE3Oa20hb9Bxx+rzfFNjohFpNlAYedOBfurji2vzYSy1Hm2x31hTJRP0nHnzG8cyO4tib4PzEYnwy4WI4U4OIgftP3/VjoE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB4409.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(39860400002)(136003)(41300700001)(9686003)(6506007)(53546011)(7696005)(122000001)(38070700005)(26005)(38100700002)(86362001)(66476007)(91956017)(83380400001)(186003)(64756008)(8676002)(66556008)(66446008)(921005)(76116006)(33656002)(5660300002)(2906002)(52536014)(8936002)(66946007)(71200400001)(110136005)(966005)(478600001)(55016003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XPVAO+onSWt0RhrCAUMl75TZts/M/UXzdTfHPcKdmF7WRaYqoyHwAdvG?=
 =?Windows-1252?Q?Ob5zaNYimQ91VJgI0zkmbhUi9EnL9SGa5Vq1H5YcJLNjdIt14oCi3Jvm?=
 =?Windows-1252?Q?JuE9jHwO1WEn2io7jbS2Kwww1acDHA+DJfja9FR6nNENpZfe5LMYj8Vm?=
 =?Windows-1252?Q?iCAks7n1hkoIL6ZUrJWbKW1AT7RkYeG6WOp7tOJHyR3yZknDUqhVv+3+?=
 =?Windows-1252?Q?ZcnO0iyod94BgMxDJ7Wl/vrWsgNu7nLJQmJ3Ipn7igw8CKfWKiDweGhB?=
 =?Windows-1252?Q?kr9ruFSlJr6zOuY+YCNIPKtVnIPdzkwzHnGFS4k0hDshhEKV1lvVP+yy?=
 =?Windows-1252?Q?UPRVaM9/3rU6Wh435Yfebc7ezLvJLVgHFxttZYrhQRVa+0M+2aBAFr2w?=
 =?Windows-1252?Q?sTk8CpU2ijXlZGaXlU1aJDZSx4Rn5fL63P/Nd4kkkZ4uhUyMKmKUzx+l?=
 =?Windows-1252?Q?fxCgQJ2kQ9wzpyPMMLR95+BQ0LuW0lVq1nNukgRTm03+ZKWl/hRHPWx5?=
 =?Windows-1252?Q?0DkUuUFqYuYaIwFuZG2R0AieN84OGankeVs02E7bBVDER1zOq4Js1yen?=
 =?Windows-1252?Q?uNHeoYdv2exMzdT8MQqiTnyGCVPgyn00YyDl6ImtB7xjgz5mlnNP6wKv?=
 =?Windows-1252?Q?NBQQF7uY7N5Rsgtf8ifM25ZwZFG+0/uLa0ADu6AjLAEyCqoPDhPAkI5V?=
 =?Windows-1252?Q?yyOLMwKPW6diG3QKspnPdd+C6Opt9myrwdHbULGEj5QQtLEO46+cGJ6Y?=
 =?Windows-1252?Q?Yo1l1yDfaOwqlB5fzhOYLdE8xYw0Rc1oVsAnvGYh9X7bfqoyN2Lt+gN0?=
 =?Windows-1252?Q?LwofAwnUE2Xqpk8K3sEBB/rXhb3dBaelGstk7IB7s5mXk1SUkqciFFfS?=
 =?Windows-1252?Q?aOGW1xA95HfRfeVCeZe0DemdKu/AWc/KTxl1ka4QPmXMT0vXMB+bRiom?=
 =?Windows-1252?Q?pOuQe7zDQfeEszbHhiN2QqCBvzAHyB88T8Vdtec2XGmb/IJNvWvbJ+RJ?=
 =?Windows-1252?Q?AUw2DsKJGrXwSSnTu8Y/zRrLD65A5kfD2HKTjrzDWwtEpk3DhvI/675C?=
 =?Windows-1252?Q?Y1DENXxrAMu/YStBNa45/A9BXmbVZcH298sMBnKqErOzIS90DwjmiLbQ?=
 =?Windows-1252?Q?Kz/PpK9NZmzlCoMIxgPi+jill2scG2oURMZEeRivOI/gBD4rbwhJ5B8/?=
 =?Windows-1252?Q?9IfAO7jZiSPWoLHttnLqh0lZ8hKgvwoU8JlcKag4V3RjIbFWcBi9TdK7?=
 =?Windows-1252?Q?ZYBpJx0Uih7B3lSzZIxCzSMi9AMlk48QF8kPGXtlKbaKD33TNxo2D47p?=
 =?Windows-1252?Q?KBH6wyK+oQ2NZKf3/u5Pa+6VV1BOBOkT1c41QPuSDnX25fTOAFqM82A4?=
 =?Windows-1252?Q?Wt2opuVKXMbqe4NnzHT1RuG/oaby0UKnIFAyQZWzFVE9GtC9QvgcAQow?=
 =?Windows-1252?Q?YlERCPDpsiRWa1lk6HjeMHbdyPqjosuA72oazZMYVm5felAjtB5ielk3?=
 =?Windows-1252?Q?4gvCJaSQePksGvmlKDlQH054Lu9tCCQmN/XZlKbYAnxCpSqqR6Ot8aYy?=
 =?Windows-1252?Q?B87g9TqHucb55O+hr07Bw3BVq9Bvu/Agznnf2CZ6PNyzTQTcwarkBzsn?=
 =?Windows-1252?Q?mCcE3VbMUloMF6dCRTx9GEB1nhIGDcD+0Kja0mqmynrRU3rDB+GM4PTj?=
 =?Windows-1252?Q?2g0lA1qK17BROTUm22zjCCjoDHGY+asa?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4409.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d8958-db5d-43f0-68f1-08da79b9d276
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 03:47:03.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MN1rvm7pXb7l509O/pQaKlbG4q6kc9MEk/x8X5JUBrRSkU9Rs0vEjOlyiai0qby7620MEqa8mmQ5uQ/aSLxkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4494
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend the mail as plain text because previous mail with rich text makes so=
me mess and forget to add others at Seagate who worked on validating the
patch as well(Muhammad, Michael, Andrew, Varun,Tyler)

Hi Paolo,

I am from Seagate China and face a problem when I=92m evaluating the bfq pa=
tches. Could you please check? Thanks

Issue statement
When running performance test on bfq patch, I observed warning message "bfq=
_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hung s=
uddenly after some hours.
The warning message is reported from function bfq_actuator_index which dete=
rmines IO request is in which index of actuators.  The bio_end_sector is 35=
156656128 but the max LBA for the drive is 35156656127 so it=92s beyond the=
 LBA range.  I captured the block trace and didn=92t found request LBA 3515=
6656128 instead only found max request LBA 35156656127.
I=92m not sure if this warning message is related to later OS hung.


Problem environment
Kernel base is 5.18.9
Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
Actuator LBA mapping by reading VPD B9
Concurrent positioning ranges VPD page:
LBA range number:0
number of storage elements:1
starting LBA:0x0
number of LBAs:0x417c00000 [17578328064]
LBA range number:1
number of storage elements:1
starting LBA:0x417c00000
number of LBAs:0x417c00000 [17578328064]





From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, June 23, 2022 8:53 AM
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; jack@suse.cz <jack@suse.cz=
>; andrea.righi@canonical.com <andrea.righi@canonical.com>; glen.valante@li=
naro.org <glen.valante@linaro.org>; Arie van der Hoeven <arie.vanderhoeven@=
seagate.com>; Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator drive=
s


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


Hi,
this patch series extends BFQ so as to optimize I/O dispatch to
multi-actuator drives. In particular, this extension addresses the
following issue. Multi-actuator drives appear as a single device to
the I/O subsystem [1].  Yet they address commands to different
actuators internally, as a function of Logical Block Addressing
(LBAs). A given sector is reachable by only one of the actuators. For
example, Seagate=92s Serial Advanced Technology Attachment (SATA)
version contains two actuators and maps the lower half of the SATA LBA
space to the lower actuator and the upper half to the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. To reach this
goal, the block layer must somehow control the load of each actuator
individually. This series enriches BFQ with such a per-actuator
control, as a first step. Then it also adds a simple mechanism for
guaranteeing that actuators with pending I/O are never left idle.

See [1] for a more detailed overview of the problem and of the
solutions implemented in this patch series. There you will also find
some preliminary performance results.

Thanks,
Paolo

[1] https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYePr=
A0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LRiTVoIO=
UC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLONHEoI3p3e9Q=
NIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYBFn5S2WjBDQq2kzDz=
ZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEVa1b6bQByX6grF5pn3pTIo=
0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIKDrNTALs3xQvg03DH4jLez-T2M9=
xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F%2Fwww.linaro.org%2Fblog%2Fbudg=
et-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sa=
ta-hard-drives%2F

Davide Zini (3):
  block, bfq: split also async bfq_queues on a per-actuator basis
  block, bfq: inject I/O to underutilized actuators
  block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
  block, bfq: retrieve independent access ranges from request queue

Paolo Valente (4):
  block, bfq: split sync bfq_queues on a per-actuator basis
  block, bfq: forbid stable merging of queues associated with different
    actuators
  block, bfq: turn scalar fields into arrays in bfq_io_cq
  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h | 149 ++++++++++----
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 493 insertions(+), 243 deletions(-)

--
2.20.1


Seagate Internal

Seagate Internal
