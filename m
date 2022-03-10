Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1434D43C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiCJJwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiCJJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:52:51 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9A13AA25
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646905908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shxYbpJgbJqgRYYhljgwFoQLTDzHV+faY8kyLQQzU9s=;
        b=U19llt8zRuTKDcdHATczdQxGNT6CzAqB5h362uU4CZkoF+K55C2nHRrtQ7ugAWxy8tGSBG
        aDumaJ7tFLaFsIc4/aiUgrRiR3IrI1e++HZOj/VZEWbKCgh4CJr5hairFEw+B2YyJBed09
        RtSwPDn6JFFnrtN9lULZIy0Rne7dVOs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-L-cj7p5SMCC1Q7ra-xBKvQ-1; Thu, 10 Mar 2022 10:51:47 +0100
X-MC-Unique: L-cj7p5SMCC1Q7ra-xBKvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4cwg9H7NgCpTZRarA6vccSsnJFcm5RBqsH/KJOplydotQxvxZURjTSOw9zlYNVkg1q2pHGnzGwOy3XObxh/biYr/VKIKyYbq1BvNXaorcHKj3AQWt9NZwXdHkUvwTXW1hYdvu9bwoUejf6sbWPIIVQ/vng0jzbRSPTJzMupPZKQGgRGUY6OU/T386B9txrxWDGtD6qhy+wUD0Uo/VwFZuYDcuHEnX8+F1Ey68sna1t/qN2mRxAOP36CKlTrx84W5s3grur9hjySP8wq0BfxRtdGOk7RPUJ1N+s5aw/e36Us3M3zM3bT3dGAdgfZ+hLhWHLHMXfgNOmebxDXvC7zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shxYbpJgbJqgRYYhljgwFoQLTDzHV+faY8kyLQQzU9s=;
 b=Lfigk9ls706JY/Z6/3JFR3KqpM5ISQkTzcI3tF4idMIdS8ynwbsldExM4Vj/ZdbUA2HNlLU0Eu/RCvbnaHVj6wour2mdOdQ5uqtDLwzaUfNOkP4J6aZqm9dkBHAkoEduUYL3257AF2LNJuq6NkoORYRn1vrCbm0mn11K2C8C6dFq+hWBTSCHNmJL+N3PguQ8GQgDkK1CI4uVZ7GiVzGfTQDEphS/4djE7sTrVt/DGq38gSachDw+eiVxnG8GCfVilpZHTlZF0f9nQXLZT+h5792Kq/k4IYiJbUTPhanMv3HfZsSy294huKqJxVhJxVk0eSuFue281mCBRTPsvgPXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by AM5PR0401MB2497.eurprd04.prod.outlook.com (2603:10a6:203:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 09:51:45 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::98e0:cb7:30fd:254f%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 09:51:45 +0000
Content-Type: multipart/mixed; boundary="------------xieuLjBblag4Fo0PVt3Rboxb"
Message-ID: <b7bd6b82-03e3-eac8-21f5-1b05c97c98a3@suse.com>
Date:   Thu, 10 Mar 2022 10:51:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] memory leak in usb_get_configuration
Content-Language: en-US
To:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
References: <000000000000351b8605d9d1d1bf@google.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <000000000000351b8605d9d1d1bf@google.com>
X-ClientProxiedBy: AM6P193CA0052.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::29) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 745de1ae-ebfe-4034-6b3e-08da027b95f7
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2497:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB24975EAC729901261CD2610EC70B9@AM5PR0401MB2497.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tt1pniaA//9efB6d96hMStfALaL88jdNJgn1yvoQeed26VxYJeHJmVvzHVADAJBGTHo7WS3BZCcZrXJQzKgSsumd0/dJNKPbNt8fBaIXSu1ImGnuNUGX+J/Bu3IRB4xtvuhS8XKlVTQ2tST+VV8i+LBVeUkj+doY38y5jpSy4d3u1XUs2B+L/beAV4WRs1Tpow4zAzlYSKJxaqW223Fyd/KQJIz5BHHoDlEHLupv1E+MMi2L+yccbLkUFcbksbA8k8OqtF6uddBVmLK5KMutf5YLwc6uL4jVKnYOeAWBv06fsVKQXP179+VLd8pxFjTtdNGKqzwb05ns0+92SW2EaiD7TLRF8s/n/NCR990Jy8H4v61E7xkAc7gcD9La6FGepItDQXJv85NvqXB28htSeqaPPc4II53gXHFNKBxkFuTfh/nRBjtZel7s+PYXvnOHXfvbNMBO0TyWxF2ldHHMEk0NNExGPLgD6sZ7p51hey1Beea2c24EOOvxKVHFXO50TLYTK6QzR+VjOVvBu2r02HsmOMHGwKoN04KRzVZV52TCFOOqrb8o69HSvGK40a0qY8StQD/0Swz0TgBtnMEd0Z2WCHHYMYt+aeMJHEJvDYetLiSf0eZHoUIUTx6q8C+EIhb5dNWtToc3QBS/+QOJVtH1cS+Sxep6nJSFau22G3Q4GiHJLNrzTNsuBCh/bmxAE7yaUKul6X6W9iCR8HN8dshrH+15rr10E0/Oo5ZSvp4z+SMV/V0wVowMBko3EgN2JrFuydINtWP1zYERtwUw+ZDJinK/sL+OhEAjhUT033BA8DjFsR3q2WgNIqmBB3B2/Jx0YLk1YBfmIHyQiKWa1/Mo1TsaTrDWLoxZSnWWUAJRizkukKKMl0PaImID/O7z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(33964004)(6506007)(6512007)(186003)(2616005)(66556008)(2906002)(6666004)(31686004)(83380400001)(36756003)(6486002)(5660300002)(31696002)(8936002)(235185007)(86362001)(508600001)(316002)(66946007)(66476007)(966005)(8676002)(38100700002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpQK2FPcnFWNVZLWEJVYktXdEhaQWtGWkFZUTEzMlJLTnh0L2JFZ3FmS2VE?=
 =?utf-8?B?ZWtUaVR2TnRkTUtDblZLSkN5TlBkbHZHbWZnSmFnRDBST0dJbTk3cS9uQjE1?=
 =?utf-8?B?S1MwdDlaVzA3Wlp1S3l5Ykl3Wmw1MlNZM3NUQ084NTlwZ3RQNU9oZDFjUlFU?=
 =?utf-8?B?YXZpc0hDbnFLcVdmZFZ5WTRKZGtqTVdTR0k1K011dGJzVGJOY09LQ083bzcy?=
 =?utf-8?B?cnZXcHNMMnY0WGZRalFBcFJDSkdkUUEvU2pnVzAvbTFOOTVzN09SREhOYnYy?=
 =?utf-8?B?Nmk3WmFjQ1cxVE5wRTB0RjBkd2hsWmVvbDhGR1FtV2Q5ZXJyVGg4L0tUbEhs?=
 =?utf-8?B?VE9YNnBFaUpUc3M1RThyYjAvOEptbmFmZXRqWm9jeks3R0JhMmxrakpoOTdF?=
 =?utf-8?B?Sk40c2hTVjhPSk9HbDJNL0FYSExZeGlkY2NRcjY1QSt2UzNtSnNSZmZnMFJn?=
 =?utf-8?B?Q2gvRnhSWkVkRXJvRjBodkMrTFRFOGMvMHNqenBrWTBaNUJmVmtJT042ZE96?=
 =?utf-8?B?VlREM3A3RkJPVWp0dUpkeDRiZzRNK2xaT0lFZDJFa25xMWNxeGhCcjlpWmEy?=
 =?utf-8?B?ekJLZm5JdDFISStwSzc3RmxnTEp2UytlL1BWL2E0am0vRnFmdnJzdFBReHM4?=
 =?utf-8?B?WVhMaTRSUUpqQXNlRmowTkRVa3piUk4yMzJxenlpRGFrSnhwa3prYXNGWDBZ?=
 =?utf-8?B?ZmJSQnNoVUhFcFZDNHlKZ25HNHlYY3M4cER6TXRkV3Y2OEVxNU95dExXYjdH?=
 =?utf-8?B?d3hHaGlKSWRGMEFpWTNjclVYR1JyQ3dLSkRjSkRlTkhhN2twS29hZTNBVUYr?=
 =?utf-8?B?d2tKNm9pMlhzbjBSZzRXRjh0YlVRa3dwZnh2MGVEUUNNZ2NaRDNvTk05cjc5?=
 =?utf-8?B?OEVtK3RFOUxoQ0poTWh3Qm5QYzV1Y2dkLzZLbFlGbVJvc24vS1dyai9PN05Z?=
 =?utf-8?B?Y0tFMXd4Y2R5cWt0ZGNWeDFXS3dVNUswWlAwOWZ0UWcvQmZnTmVKRndVVC90?=
 =?utf-8?B?ZnhLQ1AraDQ4a1d0dFcxMkUzSGZVZkJ6WlI4TzB3VUhIL3pNQ2VlVS85NmRR?=
 =?utf-8?B?OTdSN21BUkxGOXJoZEFRSXZJMnI1VWtESEl3bVlGaXpGR2VlaU8yQSsvcnNJ?=
 =?utf-8?B?czV1cVFoYkYzVk5yRThaczdjazNpTk12Y2JQZUlGVDBvYVNYQlo3REFpREVD?=
 =?utf-8?B?NU52NUk2WUhyWHg1V3E0bG5rRjRCS3ZHQVg4N2tQaHUyNi94c0dWK3hFanU2?=
 =?utf-8?B?RTA4NGllOXh4bXRTVUs2cHNWU0dLNEN5elcvcmRVZnRHVHF6bEZmN0FGclo0?=
 =?utf-8?B?K3ZGOG1MbFJpQ3UrTjVXZWxOTTRYN0p0TnAxa0VHam1qd0V6WVlBdjBLYlZi?=
 =?utf-8?B?ZW1NS2gxNmM2SWhHUzZ2NFMxMXNyWlRweCtENE1GbCtsV3lTM053V3l1YnhY?=
 =?utf-8?B?QWJoUGEwY1p0S2dOaDNQTFlnaGp3N3JBYyt3eENMZnE0UStmWXJGWmFYSDJ1?=
 =?utf-8?B?ZytjRmNXbjJGVUltT3UzRWxEZXhPRGFrRnFJcDBERUV2VWZjSkl3SzJYcHJ5?=
 =?utf-8?B?L2pIOFdPSkpXNnpxQ0sycWxmcm5vTHFBZU51c0cwVjYxL2RNZDF6YXUyRXVK?=
 =?utf-8?B?UFB5TWFiTVlvSVFNczRwa0k5VTN6NVhDTnM1c3JVZzg2QXR0QlJFY0FjaFdR?=
 =?utf-8?B?bmRQYlNsR1FXWkpldVdlcDNHdEpNTi9JdFplWWhuUS9FQkZWQStTS0x3Y2p3?=
 =?utf-8?B?d09LK1lyNTFrRnNwSnhPR0VPUElzMDg2WGRUdTdBWTJnMmgrdUdLRXlteXJq?=
 =?utf-8?B?YWszQWJhVWMvUGNKclhBS2JINDhiUlE1eVU5OURKRkp5bk11ZndxM2F0Nzls?=
 =?utf-8?B?TG91T1RDbDEyWC9pN0pjS0VkZHhzM3E4Z3REOGhZL3lOY2lKb2NTL0tKNDJK?=
 =?utf-8?B?NlNmWkNQaTV5UTEzM1FVcTJ2U0FkcDM3Um5BalkwUlZ6ZFdiZnEvRU94TkJR?=
 =?utf-8?B?R0t3eFE4T1FtV0FHdUdFYVZ5OU15ZHk1YmFKQVFpd09HbG4xNDZlNVFDUklk?=
 =?utf-8?Q?ktJL9e?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745de1ae-ebfe-4034-6b3e-08da027b95f7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:51:45.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm8zw4Hoy+w0fNmlyYQ9gpNh5Qhphq9cNu/Ol/7vicGVrTu2j99lYB0RMtgOXXe1FIfwGDUCXMj1mhuo8scW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2497
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------xieuLjBblag4Fo0PVt3Rboxb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10.03.22 00:54, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
> dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
>
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0014404f9c18

 
--------------xieuLjBblag4Fo0PVt3Rboxb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-USB-hub-fix-memory-leak-on-failure-of-usb_get_config.patch"
Content-Disposition: attachment;
 filename*0="0001-USB-hub-fix-memory-leak-on-failure-of-usb_get_config.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ODU2MDlhYjBkOTVjNzUzZGMzMTI2N2IzYzRkYTU4NWMxNmUwMjc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUaHUsIDEwIE1hciAyMDIyIDEwOjQwOjM2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gVVNCOiBo
dWI6IGZpeCBtZW1vcnkgbGVhayBvbiBmYWlsdXJlIG9mIHVzYl9nZXRfY29uZmlnCgprZnJlZSgp
cyBvbiB0aGUgZXJyb3IgcGF0aCBuZWVkIHRvIGJlIGFkZGVkLgoKU2lnbmVkLW9mZi1ieTogT2xp
dmVyIE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9jb3JlL2NvbmZp
Zy5jIHwgMTcgKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvY29uZmln
LmMgYi9kcml2ZXJzL3VzYi9jb3JlL2NvbmZpZy5jCmluZGV4IDQ4YmM4YTQ4MTRhYy4uNTQ4Y2U1
Y2E2ODQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL2NvbmZpZy5jCisrKyBiL2RyaXZl
cnMvdXNiL2NvcmUvY29uZmlnLmMKQEAgLTg4NSwxMiArODg1LDE2IEBAIGludCB1c2JfZ2V0X2Nv
bmZpZ3VyYXRpb24oc3RydWN0IHVzYl9kZXZpY2UgKmRldikKIAogCWxlbmd0aCA9IG5jZmcgKiBz
aXplb2YoY2hhciAqKTsKIAlkZXYtPnJhd2Rlc2NyaXB0b3JzID0ga3phbGxvYyhsZW5ndGgsIEdG
UF9LRVJORUwpOwotCWlmICghZGV2LT5yYXdkZXNjcmlwdG9ycykKLQkJcmV0dXJuIC1FTk9NRU07
CisJaWYgKCFkZXYtPnJhd2Rlc2NyaXB0b3JzKSB7CisJCXJlc3VsdCA9IC1FTk9NRU07CisJCWdv
dG8gZXJyMjsKKwl9CiAKIAlkZXNjID0ga21hbGxvYyhVU0JfRFRfQ09ORklHX1NJWkUsIEdGUF9L
RVJORUwpOwotCWlmICghZGVzYykKLQkJcmV0dXJuIC1FTk9NRU07CisJaWYgKCFkZXNjKSB7CisJ
CXJlc3VsdCA9IC1FTk9NRU07CisJCWdvdG8gZXJyMjsKKwl9CiAKIAlmb3IgKGNmZ25vID0gMDsg
Y2Znbm8gPCBuY2ZnOyBjZmdubysrKSB7CiAJCS8qIFdlIGdyYWIganVzdCB0aGUgZmlyc3QgZGVz
Y3JpcHRvciBzbyB3ZSBrbm93IGhvdyBsb25nCkBAIC05NTIsNiArOTU2LDExIEBAIGludCB1c2Jf
Z2V0X2NvbmZpZ3VyYXRpb24oc3RydWN0IHVzYl9kZXZpY2UgKmRldikKIGVycjoKIAlrZnJlZShk
ZXNjKTsKIAlkZXYtPmRlc2NyaXB0b3IuYk51bUNvbmZpZ3VyYXRpb25zID0gY2Znbm87CitlcnIy
OgorCWtmcmVlKGRldi0+cmF3ZGVzY3JpcHRvcnMpOworCWtmcmVlKGRldi0+Y29uZmlnKTsKKwlk
ZXYtPnJhd2Rlc2NyaXB0b3JzID0gTlVMTDsKKwlkZXYtPmNvbmZpZyA9IE5VTEw7CiAKIAlyZXR1
cm4gcmVzdWx0OwogfQotLSAKMi4zNC4xCgo=

--------------xieuLjBblag4Fo0PVt3Rboxb--

