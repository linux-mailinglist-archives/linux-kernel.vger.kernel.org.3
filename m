Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39F4D009C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbiCGOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiCGOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:02:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80092.outbound.protection.outlook.com [40.107.8.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ABC8CD96;
        Mon,  7 Mar 2022 06:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgPoz/n8YjaBao3JhNJi+40JJIqt4fAZx+35CTUFWh2HKl/NIVrbMHgJ/k7SB9mcxie9MH2H+Ckt1JFwScoU9eHjEN2FxplmyoadJq8xRqWNtk0vpyDyK5bGjJDvOVSDYT3QATFz8GWYDBithICttFoPR2YdeiAE5YzS16hBngFmgI5TWafnck9UUHaMvo58EEoQNWVpcUwoAjy3V2XMr/oETXqZlMBjnHD7hPb9H+TFo+fP28Jr/DMvm/Fe3ThP7wG7UJ9+5Pg7pff69vHScZ2/dlcjUgWm+eBBRD5usHa/jrYZZ8khkbm3MnKlhXt7e+aRnwjWjaZV+x+GVT0A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUP9peDlDo/Td1LVae90A3Y+yyMi8RBJyw9TK1L3Yds=;
 b=m9FMunV8pNcNf2ntOo7r+j8LleBUK7RFOpeWIpJcjZ0Qt+d2wZyf6tvWNpwaWILGSr575NREPBYY8vNSZNiZlkN4EqwwAW2RhZTdp6ZvPoc32kiZVeccy8n6XJNQoTmeHQv1sk52ADQXyFJCZNA7/v33U4U4l98xQWQuP14X2vpFL/V3zKozIvAhqlflTN8NG2IkxWeRWoVaQlNnbci6+VwUJ7VmH8DJijzf20rN18OHofzauxYxAOJMOZNEHTdOgdHQt89l9HaHkaGeMNpezRhc+j8xE7ZDHo+04TlGYeK2Fh9Sd5NFOSUyYqlMf2tWaOpx8yEPKKHDh9kqyx80cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUP9peDlDo/Td1LVae90A3Y+yyMi8RBJyw9TK1L3Yds=;
 b=O4alZyTqyaWU1O7YP1DqAmssHHuPfqOYiQBuwFjXSuUk7gowdD7bEF+Eq8p9Gr/2VcmezqdOVvrtlobjk/rrnQZLiNwWytOi6e9UWwr1sc5wE+IgBovEA5STJVhyQPoEPYPNaiuf+Hd0pCVPVeXzfbbLb4Il0XGXqn8hnDeeRcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR0702MB3700.eurprd07.prod.outlook.com
 (2603:10a6:208:23::27) by AM6PR07MB4520.eurprd07.prod.outlook.com
 (2603:10a6:20b:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Mon, 7 Mar
 2022 14:01:21 +0000
Received: from AM0PR0702MB3700.eurprd07.prod.outlook.com
 ([fe80::b18f:df55:c5e3:8e1d]) by AM0PR0702MB3700.eurprd07.prod.outlook.com
 ([fe80::b18f:df55:c5e3:8e1d%6]) with mapi id 15.20.5061.017; Mon, 7 Mar 2022
 14:01:21 +0000
From:   Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Mathias=20De=20Mar=C3=A9?= <mathias.de_mare@nokia.com>,
        Joeri Barbarien <joeri.barbarien@nokia.com>,
        Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Subject: [PATCH] tools build: Fix parallel perf build when building in-tree with O=
Date:   Mon,  7 Mar 2022 15:00:47 +0100
Message-Id: <20220307140047.26910-1-thomas.de_schampheleire@nokia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To AM0PR0702MB3700.eurprd07.prod.outlook.com
 (2603:10a6:208:23::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee159040-777a-4776-a1ee-08da0042f55e
X-MS-TrafficTypeDiagnostic: AM6PR07MB4520:EE_
X-Microsoft-Antispam-PRVS: <AM6PR07MB452011AA5A08561C4E3F6F97D5089@AM6PR07MB4520.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Xl5P71bjzgd951EqPf85RcrwCiu9O7Y+KMUXE8B8vzIkH76hVX1o8CCIGsws92Eukaz/0yDftQieD+yhL6onQFjFB3nJh4bnt21Bx7gB4Bz9V1j8sjQ/5WVIQcLGaQcsQiAXY6jFy6PDSYDvkP2mIhGhDYUxgdx2f64aLKX/ZzYCdDe6l6Jmf4XlewQaWvEWj+OJUyfDqWHQbZcf7r+qjeRg5vX8mfa0sn4qO0heXckj5P+u/7VmAWJLrNuVIJEjcT8zQTuepugMaXReB4lWhb5RZaQDKgirIrX8g2MnwBNL97wHQEfG8gygblAJ1AZifslXzxahiE5Ky8p5RiIk7n+wE4ipR4A2K7TdlLPGMXSzrfMKLWm6HccmoX2Xt4kh8YgAhfIOTNaF/YvRQMSebvdEursmuR7BEi+ZZLpFcU+5EC1AzExPal+8+F6oU8etaRBXJwWT1hiQIFbQTprP1XnIOftoLi5tEWO+LCGpLz9otT0wHrJvY84qgganpMzTQb9MwP+CTAzpz3NWg72NGnYaZ3w50LRN0Q6EsHahitNIjY4u+bXIcJfJGmhM8Ia/gkDipUJdiSuf9vlQztGn/VPBzI49MzmaoxVAGzcf00qpjUd1KTcDaXhKNvGcmOrIDvXLf8DWtR8Guu81egwH3NXi9lefG9SD/ywmIlJx7PvtQ7zMZVQH2qjmbx+rTaocvhnRIRk24idihX/aqso11Fj/v2Nq8vel74C9X6hJKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0702MB3700.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(2616005)(66556008)(4326008)(36756003)(66476007)(107886003)(66946007)(82960400001)(54906003)(316002)(6512007)(6666004)(6506007)(38100700002)(508600001)(8936002)(6486002)(5660300002)(966005)(86362001)(83380400001)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFpTmRmM1JiajJ1MHBXYnhjcmhWQnpnQXB0K0cvelk1dDN3Vkt0blVXdkts?=
 =?utf-8?B?VDNJd3dyemZNdjVXa1ZyQzJiekVGZ0xGZGZzbS9BeG1nQTU3MXRhaEkrbWE4?=
 =?utf-8?B?T2lkellCenNFanRjdC9YMnBnWjFvT1czT2pZbUhiTXNBb0NPK0p2QkJpNUFU?=
 =?utf-8?B?UytWSnd1T29EZ0NyM0dKdWdQckpiM2dnWUh6MkJXd3UxaEhLQzRENkE2ZjNL?=
 =?utf-8?B?Y2lyd0pOYmMxcHJHNmFSZUluTjNJc29pQU9XSVJnY3dYRXhvRjE5QkF6cWNx?=
 =?utf-8?B?QU5CN0pGcmVrMFpCZlN2VlpUVmlYdXprdWd6OWlNS2U2RFRCK01EYy81M2Zi?=
 =?utf-8?B?ZnM4S0hxcVBYZGhkZTlUbmpMMG1kMm1OdFE0WG5WbFREelJsdUtVZVVsOXZ5?=
 =?utf-8?B?QjhDelNUL2FBWVFjRVlwVWJtUFF4bVgwVEp1NUt6MzlrOVJyMmtEWktFWFJm?=
 =?utf-8?B?eDFIOW9SQTRaSm15dUhuMHVoeCtldmFib29JMU1oZ3BxRXR0N0w1ZURXTVNF?=
 =?utf-8?B?VERPSDh5N3NkWWR5M0ZMZSs0SC91b1JIZThnNVRKdzhzWmJTYmlzT3htQ2VK?=
 =?utf-8?B?OHRyazdLcGoxR3NvRUJvMDh5SEFIdnVZYXI1ZVRnckpjL0VOUzNmUmtoUzVl?=
 =?utf-8?B?TFFsK0ptWlY5WEZ3NFZua0Rrd1RqRWh5Vlp2alU5SzQxcXdKNG9Nek8xMVl2?=
 =?utf-8?B?Mi8xcC9SNWtFWnd0c0tsMGQ5dnY1eEJKNDBhbjczV3FFMXpyTmEvQVp3SWM2?=
 =?utf-8?B?RmVSRHFWdzRSWjhOREl4OE9nbVNxUTRjUDU2RFBEN3N1WXV3YSsxTkhGOWU4?=
 =?utf-8?B?dG1MMTQrSjJQKys0bDM0ZEJZZlRobjlJRmJTOGVyaE1pRzYwNVZTUDBzU2N3?=
 =?utf-8?B?Zlo0YVhGK3gwUHBxSEZTTUNtR2p6QjFFSkJIT3lJTWhMZmVrTGxoQjlnZ01i?=
 =?utf-8?B?OXFkdHNteEdpbHNCT0wzdUo2MzU1elU0VWlNdEVtQUxPQXduRlFTditxZXZq?=
 =?utf-8?B?ejh0UkoxV3ZuVmp0T1l6NCtlYVhhL3pGSW9nVFUzNlNnQlZYQmVNMUgxSFkv?=
 =?utf-8?B?djJUcGJmalFVZmRBdU9NM1hQVGhDaU5DUnhtaCsrSi90NGVXK3A5UVlJWHhM?=
 =?utf-8?B?TXhrM1ozbnEycHUxSy9IaE5BZkZNRzhGMUplQ1ltbVdKYm9sV3JIa05LR0hS?=
 =?utf-8?B?eTZTbVFnTUdkYS9Cd2RuWVVYZTVxSlFWYmJzelpzRlZXdUx4NHRzcThKMEtH?=
 =?utf-8?B?QkNLR0s4Q1BTNVFTdGxSU0NyWnUrcUlhM0R2SEZ2OVp4dnFpWEU2T2l0RkNV?=
 =?utf-8?B?MHVWMCt4V29mWElOc0pGOEY1TWsrVlg4anZNMzJNd0xHSEQ2VTdnQmtvcngv?=
 =?utf-8?B?czI5Q1JjaFlKbHp0MWVWYmJaN0tKZzNxZ2k0V3Q4M0F0MGo0QUZleXM4NTRs?=
 =?utf-8?B?WE5EQ2NlRlpYL3NNNFd4OG1ma0pOVUtHTDU3anJEOFR5QW54L05TNy9XUzNL?=
 =?utf-8?B?eUxWOStBMmN3S01UMmVmeXZxa1A0MEhCRm14Q3VMM2k1eHl2YWRUSXRxQyt6?=
 =?utf-8?B?ejNuZ1c4M1RIQTMzNVhsK3NKUTVwczlDVDloWHRKZTNheU1XN1JKVVB1NWVE?=
 =?utf-8?B?ZGFMcW1PbmoyaUUvbDVwMjZ0NjVBdDB4TEowV0p5emUvNzBOQ0tpSE1JUFVE?=
 =?utf-8?B?MCtvN2U5b2ZxZUNZWmsvZVdnR3N0YUNDZFBUaEZJS1JBK2EzcXNWWDRqYW12?=
 =?utf-8?B?OUJrdmIyYm0xWDg4YkRGUnN5SmZsWnYwNWhWQy9pVGZhcXdkbzdkRDRVdlpG?=
 =?utf-8?B?TjFMUkk2SVJTMzN2S3BWNko2b0VCdTdIMThDelR2NGphRjY1ODNqQUVSZ1Vm?=
 =?utf-8?B?eUZjNitQaGErZzFZbXRMTUhNLytoRitZbHhrZldEc1NIbFVQb2hEeVp5Vlo2?=
 =?utf-8?B?Zit1ZWpGMkhKc013MmhKTisrZndMazFYVUZlZUx2ZlczQUJpNHBEM1dwMjBj?=
 =?utf-8?B?QndFQ3ZWb0VuY244Y1gySGFMZFFPY3dlV0FsRzhIRzhpdHYxTHZoUzhnQml3?=
 =?utf-8?B?QS9DRGl6a0Y2UDVsSFF0aE5mNGZmeFhoSzZBN0JzWjNLY2ZpWFowTTNYQVJD?=
 =?utf-8?Q?ezfE=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee159040-777a-4776-a1ee-08da0042f55e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0702MB3700.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:01:21.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ur8paHpZQk/4yVV5eLVtDPcZFMBcSoRUu/7LFGxLbSZANBxibjAa31R2gUDFdjZZ0c4PtOX8HYVailzGWXOl34R3jsbNjYE8Hp0yhaqZigD7p6XUzEcjo0pOwTcJ17xw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4520
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias De Maré <mathias.de_mare@nokia.com>

Parallel compilation of perf using following command may fail:
    make C=tools/perf O=tools/perf JOBS=81
Such command is executed from the Buildroot embedded Linux build system [1]

The encountered error is:

  ld: .../tools/perf/perf-in.o: in function `parse_events__scanner':
  .../tools/perf/util/parse-events.c:2204: undefined reference to `parse_events_parse'
  ld: .../tools/perf/util/parse-events.c:2204: undefined reference to `parse_events_parse'
  ld: .../tools/perf/util/parse-events.c:2204: undefined reference to `parse_events_parse'
  collect2: error: ld returned 1 exit status
  make[2]: *** [Makefile.perf:677: .../tools/perf/perf] Error 1
  make[1]: *** [Makefile.perf:240: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '.../tools/perf'

The problem only occurs when 'O=tools/perf' (i.e. output directory is same
as source directory) and not without O= or with a different output
directory.

This problem happens when parse-events-bison.o is compiled while
parse-events-bison.c is still being written. This is a dependency problem,
but a subtle one.

File tools/build/Makefile.build has a rule with dependency:
  $(OUTPUT)%.o: %.c

For the generation of the .c file, tools/perf/util/Build has a rule:
  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y

The clue is that the .o rule depends on %.c without $(OUTPUT) prefix, while
the .c rule has $(OUTPUT) included.

If OUTPUT is 'tools/perf', then make sees:
  .../tools/perf/util/parse-events-bison.o: util/parse-events-bison.c
and
  .../tools/perf/util/parse-events-bison.c: ...
and it does not consider both .c files to be the same when calculating
dependencies.
As a result, the .o rule is allowed to start as soon as the .c file is
found, without the corresponding rule necessarily already having completed.

The problem can easily be reproduced with following change:

: diff --git a/tools/perf/util/Build b/tools/perf/util/Build
: index 2e5bfbb69960..447636f6db7f 100644
: --- a/tools/perf/util/Build
: +++ b/tools/perf/util/Build
: @@ -221,6 +221,8 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-

:  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
:  	$(call rule_mkdir)
: +	touch $@
: +	sleep 60
:  	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
:  		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_

This change enforces that the parse-events-bison.c file _exists_, but is not
yet valid.

The debug output of 'make -d' confirms what happens:

    [...]
        Considering target file '.../tools/perf/util/parse-events-bison.c'.
         File '.../tools/perf/util/parse-events-bison.c' does not exist.
         Finished prerequisites of target file '.../tools/perf/util/parse-events-bison.c'.
        Must remake target '.../tools/perf/util/parse-events-bison.c'.
touch .../tools/perf/util/parse-events-bison.c
        Recipe of '.../tools/perf/util/parse-events-bison.c' is being run.
      Pruning file '.../tools/perf/util/parse-events-bison.c'.
    [...]
    Considering target file '.../tools/perf/util/parse-events-bison.o'.
     File '.../tools/perf/util/parse-events-bison.o' does not exist.
     Looking for an implicit rule for '.../tools/perf/util/parse-events-bison.o'.
     Trying implicit prerequisite 'util/parse-events-bison.c'.
     Found prerequisite 'util/parse-events-bison.c' as VPATH '.../tools/perf/util/parse-events-bison.c'
     Found an implicit rule for '.../tools/perf/util/parse-events-bison.o'.
      Considering target file 'util/parse-events-bison.c'.
       Looking for an implicit rule for 'util/parse-events-bison.c'.
       No implicit rule found for 'util/parse-events-bison.c'.
       Finished prerequisites of target file 'util/parse-events-bison.c'.
      No need to remake target 'util/parse-events-bison.c'.
     Finished prerequisites of target file '.../tools/perf/util/parse-events-bison.o'.
    Must remake target '.../tools/perf/util/parse-events-bison.o'.
    Recipe of '.../tools/perf/util/parse-events-bison.o' is being run.
    [...]

The rule for parse-events-bison.o considers the target
'util/parse-events-bison.c', finds that it exists (thanks to the touch
reproduction) and then starts the .o generation, which will compile an
empty/incomplete file.

The problem can be fixed by adding an additional rule in
tools/build/Makefile.build, to enforce the dependency of
parse-events-bison.o on $(OUTPUT)/.../parse-events-bison.c _including_ the
$(OUTPUT) prefix. This results in:

  [...]
  Considering target file '.../tools/perf/util/parse-events-bison.o'.
   File '.../tools/perf/util/parse-events-bison.o' does not exist.
   Looking for an implicit rule for '.../tools/perf/util/parse-events-bison.o'.
   Trying implicit prerequisite '.../tools/perf/util/parse-events-bison.c'.
   Found an implicit rule for '.../tools/perf/util/parse-events-bison.o'.
    Pruning file '.../tools/perf/util/parse-events-bison.c'.
   Finished prerequisites of target file '.../tools/perf/util/parse-events-bison.o'.
  The prerequisites of '.../tools/perf/util/parse-events-bison.o' are being made.
  [...]

and here make understood that the .c file is still being generated and waits
on its completion.

[1] https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-perf.mk.in#n158

Co-developed-by: Joeri Barbarien <joeri.barbarien@nokia.com>
Signed-off-by: Joeri Barbarien <joeri.barbarien@nokia.com>
Signed-off-by: Mathias De Maré <mathias.de_mare@nokia.com>
Co-developed-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Signed-off-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
---
 tools/build/Makefile.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 715092fc6a23..0f9ec51d9c2e 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -92,6 +92,10 @@ ifneq ($(filter $(obj),$(hostprogs)),)
 endif
 
 # Build rules
+$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
 $(OUTPUT)%.o: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,$(host)cc_o_c)
-- 
2.34.1

