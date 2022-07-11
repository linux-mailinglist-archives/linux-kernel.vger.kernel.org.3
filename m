Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BF5708FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiGKRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGKRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:39:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C248EAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlINsOdvMfE9zbGvrydXYlJMjx5mUH8Kf3pUc5EZRQtLnJvd8WcIvxxratayr+rxkAGPzrgEeLnFtp8e6yBcyz8ZFGsKqyzSt3b2S07QyPHhv3o9385i5VOLhhK64v87o2kOD3H8AfxG84260dYb7v7DoP/KVaBHwmSoWsoryeQqnFlrZxrHelpp63vtQcnCytEIIzdgRQJ2leVZLc/SFz4JSitLWuq4GxFTvj0NxO4fqpHIY8N9WzJxTrarNzLF+b4pmhLPBEpVDWfRFUuw0m4GMVnt1RWzWZ0stkPs/lsXu3Y0IY6hbeuwUj0ZjmcnoAMOHQjymmza6W5kiS9Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYxh/1ZwmNZA+x1d9B6sJOIMlI4Ka2zp5gRFyfjJMuM=;
 b=V+oBMEfAu+wS+YDKXMeIkbANiXfuC5lQkmqUsrE9CDpRjBTjeUvlgsgBKSHe6HrPd/9oKQ7+CtcfMNwQWQn43VkYD/RnYhQ0wNlVE/VhpTcmdQD3PbwhDsne8mbNgBMnMSCiHog5CMXSh4DmoIqUu1KfhfoRmjUWGHK7AKfN4b7pRTulg3vhFRzs+dY2SMfSGnbtg21tXhi2jvXHbesRc07NIm9x0f29dtbRaYVWELnPa9OjsbbNmAngFzI6qPec19OX/d6MtgUUUbpTc06O7vtCTU8jUqhX1fTeqLa7uKt9OzdPj3KDOvfh/G1rfLRCi8HFwR1bxvXS76Ksfgth2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYxh/1ZwmNZA+x1d9B6sJOIMlI4Ka2zp5gRFyfjJMuM=;
 b=p09EeTbBamQy03JGRQptNxwsmkxtIe9RU5DXibhMK7UgtPaGPgA4qDvceq1dWy+pWv9/ydTzG12q6NTalq/oZSG3+vmAvz0NbHxD0C7ajSMJ7gI+vWlXNcPmw8zyd4Aapg2cHTqY8L5ECTGvE9OeQLhYGPlFdAD/QjGDDs/iI70=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MWHPR0501MB3740.namprd05.prod.outlook.com (2603:10b6:301:76::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Mon, 11 Jul
 2022 17:39:37 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5438.011; Mon, 11 Jul 2022
 17:39:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYlPRIBVYGglwRp0y21cAEvAmJeq15cHiA
Date:   Mon, 11 Jul 2022 17:39:37 +0000
Message-ID: <7672923F-D439-4867-9418-B1F44EE5CC44@vmware.com>
References: <20220710232837.3618-1-namit@vmware.com>
In-Reply-To: <20220710232837.3618-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 161adbbd-3b97-4831-53a9-08da63645373
x-ms-traffictypediagnostic: MWHPR0501MB3740:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iClMwJbQvraQ8N5it0PRg3tIDhEPR4AXuJ4K80OH5PKq3ZBw/xo0EAeEaLljuH/G+kNPUFxwhV5Qv71kEjCMzn0GQxNNaJ2hp2rfdTJHcNRR2BMksk/PZqWvKE52qQOAvMzFyqVFwYRBGAvY9oInlRnBz00phid14RCP1aOK95ZsVECqfIdu22LjT9J1cL7z++D9zO2rFHXnYWI2lQCI+EUjpEp0uUMe3wojwIwBOJ2zBl0/DJYmABY7YOB7mqV5xbr9wj6Hdg6RlVzZ6zrqZoFB+ty+HGL0JTglsjYWYPwjUgqT4IPlTMD1+pyIbVRlizgfjnR9XJ54yMex/7uEgE5+rcK2cPuFSVFNKP+eN210cAMS6p9lPSaWe3a7fPa0h87ZklF4uTOSdITqqgTb/pMcS7HThqfMEPtGY3nxcXpkHw9BQv5j6RdCgB1NUf7dHWyAfqX7wSmWrxMS2vrwdaBkkClTJAOiHBm/1cEDBDIyL2QVp+95YhRJqDuuOiyzGd3cSh3ed39lW1Sn27W+c+sn8QMcee7GW0UrAwNZVMv67cfmp5k1KjRxfRxw8Xb1PXWF0oPcp+Vo8C6MZpCyhjV54gTXb0dnt25zYCa6BuaLldNkOshZXkAwRhbHPxSJ2R3YrH0hJNGtHI9CF6WVKbQdNR8Xw5Usv0Zg7JZr+OBwcI/4jVqgp2TKXul3Gf0fh2/DdebrGoZD2T2ESIRZbmfPUlLRYRHIa0WjIHV4ZyqJJAQfTz/knx5BMd99vW7wnomwJGjo3tLLSf13u4R1ZaZ8xIIMJs6ekYpmgrflRkf8Vz9WrM0kltc4X8H5O/2TM1DY03E/tDMWsmWi/+1BXTFGBMOqgGJVZ4GlSeSpW0+62+W7JMk5B40wos2AUPl2rPbdC+CmBS8HFTttDN/HTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(86362001)(5660300002)(478600001)(2616005)(6486002)(8936002)(6506007)(33656002)(2906002)(41300700001)(26005)(7416002)(186003)(6512007)(53546011)(4744005)(66946007)(66556008)(66476007)(66446008)(76116006)(64756008)(38100700002)(36756003)(38070700005)(316002)(8676002)(71200400001)(54906003)(6916009)(4326008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99peDcIwTOXJxsnzpuuH+Ah28/9whWe4wE74MCNu7rzWmhYhm4yYASuQSN4W?=
 =?us-ascii?Q?KNKZy2Ioe9YOcZWXWbgMTYmgoWobAr+Wc0KRX/8VbhcTheBt2x4oqPXcY0/N?=
 =?us-ascii?Q?1XnDDlX77KTtYqCEcvtONnu40diRr8AzvsJ1hVB5wsRN/1IUNJLMIjGsanIm?=
 =?us-ascii?Q?ZoEHLirbb9gzL3e+anJBsn4C+cZteRgVXsIn9KMiVF5M6Hd1hRxoLuBGcUb9?=
 =?us-ascii?Q?9xGw1LOWNI3STWeFLeqdhFSHz9jTCGiZUV918hvLq2qGLDeMDuTFK+gBE7E0?=
 =?us-ascii?Q?JZD2ZhczH6Dx3YYCofRW6xryu7rrBdn1ZZi4XQfLUyZvnseyRg1OzCtqo9qZ?=
 =?us-ascii?Q?+BAl0/8lr3jyfV8TkBcsXoLR1kdsgLw9f8IgUVtTUJnSx/o4tMZ7uIA4f+XZ?=
 =?us-ascii?Q?TXHmhzuXCi01RsDg85wiT8bkusiV2nx17C/abyYMXebrJo8JnLZYxfQHLT8j?=
 =?us-ascii?Q?s+XiObLlIYwTBNbzUl+0LnX3nQHGErG0XJOA3VvLvkqj5ENrYtUApMt5+mJv?=
 =?us-ascii?Q?oQTPlKyCTNoTFwsGf7GDZQm/8ZzbkZhgfVN6+QFcS/ZBOuBWXl59elFZvHfD?=
 =?us-ascii?Q?cOZQ6azgQArausYzTTGfgsl0x28u2kx9lTd6KM9aOWtKQqSzDJRMVkRp2Fq6?=
 =?us-ascii?Q?DA7DtVgbGKO+MaemDCzV4vrVOVOT0Xe0qwOXdcZ7A2iH78TyPBV1Vmrqu2Ub?=
 =?us-ascii?Q?xsRpVZHUwf9EY89v8CQEBuxpi1Ndn132dvSbGnxQscR9XoujHLsGTeWO19YT?=
 =?us-ascii?Q?3iXV1zUiUmmqh/J3gW2h5u65ulUH6NuR81pg49IaFTEnPz1clE9NajOOCxgI?=
 =?us-ascii?Q?s+tDdoadUP8wzhNWx8aOc7WaRplmuunwsQiURMwsXLdZLCnEiGB661K7x8Xx?=
 =?us-ascii?Q?WbSoww/Z6TUQKzVw/PGk2DtwCw3+mPuiwvIaegwQYUfWtO+IClpJGpdRTaMy?=
 =?us-ascii?Q?Gchd+ntSGPSWIGVaE7X+leiA9HWRmWSVPs5JKQYucIPsemtHE17kJCObPJ8p?=
 =?us-ascii?Q?8VBqXeaJMS07AUS62jnn59w/yQaRuUYudCmpIdV8NXQyQQcyH5KC63OsZXi/?=
 =?us-ascii?Q?fJy7MdwCvA3vWCyjNF0dGyfJsYgaBvzVaULZvZXxd/9wUFvCLf9rPlO8Xos1?=
 =?us-ascii?Q?ugb5YJh080nZnxqXoDIDlySx/KSPUx7LJAGvbXorkJeIcYJuX+PDW567Wejo?=
 =?us-ascii?Q?EcIDNdTiJlcl1qFmpWmCPpe1eWqoVX+Vx/j3Q1dEe5xPixOFmILIYAoW2fGy?=
 =?us-ascii?Q?yHA5XIZEG6rIz9it9iXl2L8ap6eTDdgtLDTiv3bqSy+HsqI9qoQn3vw5eiS8?=
 =?us-ascii?Q?zX9e0nrJIqmhiFjgdJ7r/FIhkyuuyR9xav2K0NiTpDAop6iAGVsnSf8L8242?=
 =?us-ascii?Q?5h9EPmXR8cqLIW2tGaYWqfLEVbqClVwF9T9hE77i1z31UvDHJzSsiOHXUTu5?=
 =?us-ascii?Q?G/o5rcHhLfhxE1hXgWn7tC84N9C+/kUZrZlFRJYgSJi9fk9nW32tgXuQnUw4?=
 =?us-ascii?Q?VS5Hqe7uG7eiG9fOa2BoQDjPwkqMWiPjgjwF7YpbEFNXGCDrRltM2WOdREIT?=
 =?us-ascii?Q?FojLVmKBWO+tfxB3u7ycEb8rHPUqDX7vVTvpX7Y+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DC9AE5DE755064CA52EAAECEB6E1E40@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161adbbd-3b97-4831-53a9-08da63645373
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:39:37.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoCLiIaJZMBYaEf0LUJaAvz42Mdjl4xfJyYaXzEfrh216pC2aQNsxgiBdfO3WoK2NjEXnvGHvuI7nrfr3uAxoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0501MB3740
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 10, 2022, at 4:28 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> From: Nadav Amit <namit@vmware.com>
>=20
> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> possible") introduced an optimization of skipping the flush if the TLB
> generation that is flushed (as provided in flush_tlb_info) was already
> flushed.

Dave,

Can you please review this patch today?

I feel bad (for a good reason) for breaking swap/migration.

Thanks,
Nadav
