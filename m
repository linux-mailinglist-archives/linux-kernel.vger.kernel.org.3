Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0CF5A0E11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiHYKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiHYKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:41:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35880F60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knlpZg8MLM2ajUZqIZMX+TozVVXZ8w4C59bKhvAKMAkcx7rKVFeFF0OeMKlN1Ruo1kJspRVHQaY88BBXZY5okfzKQENNSp0zZmD5Q3UikvKgIIh92eZcFjl/em+FZ0F8ej/jpU9qxInRl/GuSHkT/KouZCHL4skP9n0uZKeO1OEis8M0OCGLyuzI5FAcn9ShuQiDFuVUTfyrxWHQhSLZT8j3yB274aCg32YtD5KI9NWSEEdUhtct9zsOHigHfEhzxfh9qdUV7VL64l3ihO1ICRXGNQMKmkVJF13bmTYbnWhkQkpKLd8lHgtX+8U3ZWHt8dZiaZ4BEgYSAzHjdIgDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q5X3HUygVx9TCx7hx/jtv9lXofe/q6BPW1sWC1oNcs=;
 b=ZdNnxdsq8sDxDjRKCnj+N2f1gMNmGvSTp2Clea1Me8bhxbrsThph+JfuhNApOPcbsvvcNwrGUF1eVttk+Z3jJMeCNWgROz9GIHDtIWnFlofeSgGW1Yf6UJ8lNQXvShI8R3KKKQ98ifNw7+/eqTRPdgi9beQg7w8TPq1uBlUqxlPM8ufH0rTdOiqiWtB7OvnDD0kGgy8pFCOaKNnMz7gvZJIf1GEd6GYlTfs/LhQnDaAiqZJO4EkVb2SUBRPLl33qnGVu8psIkFcnulkee43ARWSPNOxHRs+ghAKeAtjf+qF3sFO5PNL8+bikv7mBLzq+mKsat7YXRHdPMP0xgP5rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q5X3HUygVx9TCx7hx/jtv9lXofe/q6BPW1sWC1oNcs=;
 b=BkN5Yd+hlZhcIqwe9z3Gp6xO1Dar4b5tIgGiLRW9omepu43RjqaG94JeGYT2W4TYVK+64/IPSwwnOdAVu/K94HJaz37tiz03DpUNBYbhJ0t76iRVFOUMqV8t6X/QOIpvuHM7ec2wvSRNe4qRAOiHkchnfF7PaeHAyPxn2dtoe7hc0on3MjbHtbWpc+AlSeNP4ON75REyd8wnfO3nJ5Eb2M5qsmg9vq1ZA8rMeE6nGxMz9xG3o8bIa6EXjrKOdh04tD2N7fRBQLJro0Zjqb9n9PReOldaXhkbMMdUuS22XnM39HLhicZJxukXIoIwDW1DgfGQJJvUVdoNpcgw1wnPvw==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AM0PR0202MB3410.eurprd02.prod.outlook.com (2603:10a6:208:6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:41:28 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 10:41:28 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWWAAB5kAIAADNqvgAACQwCAAAE9jw==
Date:   Thu, 25 Aug 2022 10:41:28 +0000
Message-ID: <PAXPR02MB73108383655C1FB4B98C3C2281729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdN3vJ1Z+1yKfma@kroah.com>
In-Reply-To: <YwdN3vJ1Z+1yKfma@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b3615a7-a19c-4c70-874f-08da86865db0
x-ms-traffictypediagnostic: AM0PR0202MB3410:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAXW8TiMsLxtxrfjMRiNtz4fdkN/VfIqx6OntovlseeUpywKVCstnL5URygAScxaUbBSHdORR4LFW69ZGx7rqb8RuWvj22RTHBCm5AVSwx49Xr5foAv4U0h8Csd49Nh8nGFlDqPb0Jj3orns3vrmuyu+LU2DsGaHxbHu6p9hkqxp2VzHyIi4WfJ76cREYmPSIULSQzi/sv6m8j/ycp4x1KOwhYfP9xYS6NZCTcLAJTiF5DoZE4ENp532e/dHVUJNxDS1z6KcWXY6Cea5SbklZYHe5zSzw70Dq9Ac8ikXyXH/CcPcNP51cUrhbHHwqEcEjPwN+GvBf1Mq4s3GJiKyLTTL9iGe8E9YtXLXdrljuyq3vb9JXAAr9MPwCkfS+3Ip+CWeYEx31fqDsGWjGFLob/b5xWZfGX1V6tmZjd4nKf0PhshMKj7/WfwzpPna6Dwjm/KrJz0xCN6NSEX/H5JQrWnZqgytqrKeskFHLXv1fgmUgk7k870CsJJYv3LeCy+z6u6fkpDg3RfaQwiMeIkRiFK4EWwWC8lACJrgu1opyL6ZJceCcNp//yv5ik/lqzJGl6kmTD8S9yHq7mjwlk8XoZFBa9ebnsqAaSGe9oHd4rFV6OG3EZQepL4ro16U5M70MF7lzDjWr4S/dv1w0uKp7gyBJ9Pq20kJIQveYU+/LU/TsXlp1sG8ufJHog8ZxMAmiHWD69Xurs4tdbAI0XFhSefvpcNiyIQ3uPwxRHNhVUsawA4zhvhi2Iq7d8sCglag/7Z7hQAGimrwm4StYBoX/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(26005)(83380400001)(33656002)(86362001)(9686003)(38070700005)(82960400001)(55016003)(38100700002)(122000001)(316002)(186003)(76116006)(64756008)(66946007)(478600001)(66476007)(41300700001)(66446008)(91956017)(71200400001)(5660300002)(7416002)(66556008)(8676002)(6916009)(2906002)(52536014)(7696005)(6506007)(8936002)(4326008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xdz51x5LMnFSt5Wwa0Q9j+Zvy5IsIfNoOo3/5g401YeW1dnF9hnBJukxRE?=
 =?iso-8859-1?Q?2AYnJpxGecL+PMLly1bszFmkJxBocSFWkeRobQvr4IyksXM5VBPylGfTDf?=
 =?iso-8859-1?Q?FFm9ZmHVBR8pqnBc7J1kFbPkR7eAd35xaAj2ZNJ8+JiG/bGV/rc/k6TBIb?=
 =?iso-8859-1?Q?dGi/nx57AlPeQdSXVAMqAPACWMsSMbsrGgDqHScWyR+9GF6FoO9jVgNJNG?=
 =?iso-8859-1?Q?HgNYy3Z1LU9NQD8c3cmOlqBr8vR3xqrugwyEP/H5i2Gm+S6tV2pacUY7Df?=
 =?iso-8859-1?Q?q3zyW7aD61tnhO0ZVNyERs4km23uVOVASPshMYU375qhVjjm7wPlRhI4b8?=
 =?iso-8859-1?Q?N0xjBG3ej2I41zbxza0of0LNrPuwjsU5YGzXFdxbCYl9KNTMfyNYWcRoDx?=
 =?iso-8859-1?Q?AFCpfGzcNaEDhQQ+GNK3x9/Otw5dWAR8iRYu9SHQDIB/1XRLDhiwP+JA0B?=
 =?iso-8859-1?Q?Hg/D6EW1IQ8JdJQEqtOYDGWs/wgZOs+xhV72ZcpK68YvQhVd7/ZFuegVAI?=
 =?iso-8859-1?Q?8nCmlrVBBfLNjYjw213gYB7KUjb5J6HqsLyN8MfktXVqutDiIVhoWLrjUC?=
 =?iso-8859-1?Q?P7oJrxM4E31APUfAdMWasIp5E69xYmc1l6cWl0GgLwYZ2If0xnGXmWHH2O?=
 =?iso-8859-1?Q?10iPDoOwFyfXxzd7YqefynYgSTUXQRcVu3zt3pjj73CLuRPI65Ff862/dS?=
 =?iso-8859-1?Q?6Qn95xJBgka9/CI2Hrb4tKdG2ZSrDlVwx9rhOVl68t9ZJaFsUomTwtOO+V?=
 =?iso-8859-1?Q?qloCMqJ63AeDATzYvAgVL46XFvjVlisuxVhK/1t3HRqfweS8U3lAiYHHKk?=
 =?iso-8859-1?Q?waS780MAYk+fjqxb9XAFif43EAy75r7PMcajdQC3o5s7q8sjj9nB2Ji+yg?=
 =?iso-8859-1?Q?6XECIy+IKwS2hmPtXQJRplXlbNLzju44fonCvjMdqNoAybH3fRO9c1fbZo?=
 =?iso-8859-1?Q?wz+GOt8YWGrJHfNe0s61lmswOnnZMHsVniAEgRD6KkwiXUNUyZiFZSpPUR?=
 =?iso-8859-1?Q?qGGkLVrYziIHXjHpGLjtqAsGwHxHKm6+oyIulP82/VAOjvXwyWvrzQNhku?=
 =?iso-8859-1?Q?U2gyX9YIIJEAa+rILlXfkS2zkuCxJCNn5pEE5sRqnInNimcVbMbu6hLt7G?=
 =?iso-8859-1?Q?h9+F4zUvS3CplzQLiktY3e8SRffLy7qj5UXjbOsGaeQCrXaxUuX3XtpT0M?=
 =?iso-8859-1?Q?8Qlfru4a3YyUoDfDp/flvu5jhsrTxO1VVCtEKalrJcv9l54Nfdbdr9RYtF?=
 =?iso-8859-1?Q?PnGTg1iJEn2n27eTICbV/JEUdaR73jojOaL7wwqLAF6dvERNZAXJ4gzvbt?=
 =?iso-8859-1?Q?9myV7OFZqnFXEYCWICpyNoK1vjrYS67upAfH+eCV4S+GkIbX+oPTFxBtED?=
 =?iso-8859-1?Q?QBNn6+ci8+I5kDu9nLnZkJdhckVs+XcccmIfAMYBH82zqoA55WDRmCOFpH?=
 =?iso-8859-1?Q?rlvS1aXEzzfQhD7OAAqgfmvMUJFMAUBTkkFWvRS2kCTobs3Us+6SK3NufV?=
 =?iso-8859-1?Q?sfFl0udNHGxTcItUQyTglQyz6tLISIxW/9mQ+vVrs+/BOl2Oz/5imxlN7U?=
 =?iso-8859-1?Q?oUvjICTXJqUTzcZO+6xyE4qrqhSWuREWMHPyGVJ12fozqoaPM7o+C+vj3b?=
 =?iso-8859-1?Q?2bN6WlDCmIsVFxwlgO3ckSnVwqILqWlRp1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3615a7-a19c-4c70-874f-08da86865db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 10:41:28.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wc0B9fKAdYZ8HWvNiFCXb1akTxnXO8d4zBuYBGpS6pnZ9V7+9oc+HgQRtkGsGEPy0tiLyw8YaunDRzrE8Zb3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:=0A=
>> >> >And why is your version file a binary file?=A0 It should just be a s=
mall=0A=
>> >> >text string, right?=0A=
>> >> not so small, it can reach up to 512kb.=0A=
>> >=0A=
>> >That was not obvious at all.=A0 Please document this.=0A=
>> where should the document be?=0A=
>> in the code as a comment or in another file?=0A=
>=0A=
>In the Documentation/ABI/ file that describes this file.=0A=
ok, will place it there=0A=
=0A=
>=0A=
>> >And how in the world is a "version" that big?=A0 What exactly does this=
=0A=
>> >contain?=0A=
>> it 's size depends on the number of resources it uses.=0A=
>> here is an example:=0A=
>> :~> cat /sys/hypervisor/vsmp/version=A0 =0A=
>> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)=0A=
>> System configuration:=0A=
>>=A0=A0=A0 Boards:=A0=A0=A0=A0=A0 2=0A=
>>=A0=A0=A0=A0=A0=A0 1 x Proc. + I/O + Memory=0A=
>>=A0=A0=A0=A0=A0=A0 1 x NVM devices (Amazon.com Amazon EC2 NVMe Instance S=
torage)=0A=
>>=A0=A0=A0 Processors:=A0 1, Cores: 2, Threads: 4=0A=
>>=A0=A0=A0=A0=A0=A0=A0 Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz Stepp=
ing 04=0A=
>>=A0=A0=A0 Memory (MB): 30976 (of 103192), Cache: 7527, Private: 64689=0A=
>>=A0=A0=A0=A0=A0=A0 1 x=A0 6400MB=A0=A0=A0 [ 7825/ 321/ 1104]=A0=A0=A0=A0=
=A0 =0A=
>>=A0=A0=A0=A0=A0=A0 1 x 24576MB=A0=A0=A0 [95367/7206/63585]=A0=A0=A0=A0=A0=
=A0 00:1f.0#1=0A=
>>=A0=A0=A0 Boot device: [HDD] NVMe: Amazon Elastic Block Store=A0=A0=A0=A0=
=A0=A0=A0 =0A=
>> Supported until: Aug 22 2024=0A=
>=0A=
>That is crazy, and is not a version.=A0 It's a "configuration".=0A=
it is called version for history reasons...=0A=
=0A=
>=0A=
>You have a version up there, just export that as a simple string=0A=
>"10.6.2862.0".=A0 What is the rest of that stuff needed for?=A0 Who will u=
se=0A=
>it?=A0 Should it just be in a debugfs file for debugging things?=0A=
this allows the user and us to know what is the system configuration=0A=
in a user friendly ui. it isn't for debugging.=0A=
it can be rename to summery instead of version but it is needed=0A=
to be accessible all the time, sysfs was a logical location because=0A=
afaik, it is less probable to have a system without debugfs rather than=0A=
one without sysfs=0A=
=0A=
>=0A=
>Oh, and I love the "Supported until" tag, that's funny :)=0A=
today's comic relief :)=0A=
=0A=
>=0A=
>> >> that is why I decided to go with binary, I understood that the text i=
s rather limited.=0A=
>> >=0A=
>> >That is true, sysfs is "one value per file", this can not be a file tha=
t=0A=
>> >you parse.=0A=
>> should I keep it as bin then?=0A=
>=0A=
>See above, make it text only for the version.=A0 If you want to export=0A=
>other things, be explicit and make them "one value per sysfs file" or=0A=
>use debugfs for debugging things that no one relies on.=0A=
so you suggest braking the summery into files, e.g. one for cpus, one for r=
am and etcetera?=0A=
=0A=
>=0A=
>> >You have pdev, use that in your dev_dbg() call.=0A=
>> I have pdev when the probe cb is called, however in other funcs I=0A=
>> don't have it.=0A=
>=0A=
>That's for the other functions to fix up.=A0 Pass in the device pointer to=
=0A=
>them.=A0 You are a driver, there is no reason to NOT have a device pointer=
=0A=
>in your functions, otherwise you are operating on global state which a=0A=
>driver should never do.=A0 You will notice that quickly when you remove=0A=
>the static variable at the top of the file like I asked you to :)=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
understood.=0A=
=0A=
Thanks,=0A=
=0A=
Eial=
