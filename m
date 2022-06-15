Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8454C66D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbiFOKo6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jun 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiFOKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:44:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B2A44ECF7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:44:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15-KgCYn3nfPo6x7IeS2ioUCw-1; Wed, 15 Jun 2022 11:44:52 +0100
X-MC-Unique: KgCYn3nfPo6x7IeS2ioUCw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 15 Jun 2022 11:44:50 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 15 Jun 2022 11:44:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ian Rogers' <rogers.email@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Zhengjun Xing" <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Nick Forrington" <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "James Clark" <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
CC:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: RE: [PATCH v4 3/4] perf jevents: Switch build to use jevents.py
Thread-Topic: [PATCH v4 3/4] perf jevents: Switch build to use jevents.py
Thread-Index: AQHYgGTBf2pcanF4ukiDhmkMwHDNNq1QRgsQ
Date:   Wed, 15 Jun 2022 10:44:50 +0000
Message-ID: <9951ad2acd3d4454b39c4862da75d913@AcuMS.aculab.com>
References: <20220615030438.51477-1-irogers@google.com>
 <20220615030438.51477-4-irogers@google.com>
In-Reply-To: <20220615030438.51477-4-irogers@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers
> Sent: 15 June 2022 04:05
> 
> Generate pmu-events.c using jevents.py rather than the binary built from
> jevents.c. Add a new config variable NO_JEVENTS that is set when there
> is no architecture json or an appropriate python interpreter isn't present.
> When NO_JEVENTS is defined the file pmu-events/empty-pmu-events.c is copied
> and used as the pmu-events.c file.
> 
...
> +    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
> +    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3
> and sys.version_info.minor >= 6) else "0")')

You probably want a "2>/dev/null" in there.

I also think I remember seeing a `which python` in one of these patches.
'which' is a bourne shell script that is trying to emulate a csh builtin.
It can't actually work, and ISTR one of the distros might be
trying to remove it.
In a traditional bourne shell you should use `type python`, the posix
equivalent (which any shell written in the last 30 years out to get
right) is `command -V python`.
Both type and command have to be shell builtins.
Although I suspect some shells get command -V wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

