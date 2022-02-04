Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB51E4A9F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377776AbiBDSy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:54:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1964 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377077AbiBDSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:54:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214GT57k017022;
        Fri, 4 Feb 2022 18:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3W3zCKgmQCSdu1/JpvXkHQ+ADxGTlAJJr6YkfxcHzDs=;
 b=sAELIyqMTKgL6uN3yFavteqKL1TD2prd8ZQDYkhVVbhKiXqt/MrMxgYxZK/1+mLMGd4E
 SwCYAwJ8rk8BNUdINN70ypOPwvBCoJPTNsAqoJC7ChrBjHAot6/Hlx0HqwRwtmnnt/dk
 MurDkAw5OjiWdnfs5WMctHIx2M7qyCCHOfmi0XAvY4Ra8c7RGJQy9dJB7fZNa/K1DTbP
 zIldv4jKek1G4aLrl/jBh4DWnnEm0QBHQw4fUC/P7ULQ9PXAT188gBUbVXBnPXK0jdhZ
 h/JBZroJF4Tu/5uAVWo6Ds4KCi1I7rrmCLkrxwUdd15zVWbocUZrsXiBxrBe+a2fnWQh EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevujb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 18:53:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214IpZdq137398;
        Fri, 4 Feb 2022 18:53:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3dvtq82met-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 18:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpOCGA5vxv/H4bGAuK5ZJdEB9qvk49VPe4Qc7bfUJY/nDcTFP0HeRF0MpQrRt9kYOM2zEOwKjpIf1tdToG2P3H90z5LeIUDZaNlJSEipbRIsD4sFLgQLz0SIr6p89VSQz0IQT+Mt6aBk5p/e6vzdAOIzUi8u7MWrgVbpEHjaCqzOTCLTK4WjBvs0+gFgVyc7Z/JG5ws7g+VU0dhh9ojHq3qvWPHTOne3ze23yHE0WZLWv9ryb3umKt2SPNEDtlzMwRSnI0Ew68vwCi9ssr3n48hEhR8dGfNu1oYV9jMZH9KxEMErX1sU0yrcnRWau03nzgJHXPWR2BDQ60sr2CN4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W3zCKgmQCSdu1/JpvXkHQ+ADxGTlAJJr6YkfxcHzDs=;
 b=ZAJ+zE2nhK1ku+foaykBOs3gd5ly+S0MVvjSZuPwMSmzjM7EL1mwwckNaHceRaqAhCyj3FEmIRYlvKu5h1hHfAOcmbaNEOK4syy5fwMBCwMPrXHVPMNpbWh06AMn1MHm+RfxPn9rakDr5Ev6uYNarat14PtLgWFjrl8fB1vvbc53+j7cKKkjWIluXRgUeGzKBuHZRq6pve0mLvhnGOS9oq9zjXX245UEkUhj2SeBjH9/ZWCayzSOiLIj/r/Y6vvgaWDFgRDbvzPOfVllf1kiUbOf7wLUnoEv6Enue01ccU7bbtTr03HiUPwU86iGc9Xa2pnJ/bcxVTDzRVJXkTXwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W3zCKgmQCSdu1/JpvXkHQ+ADxGTlAJJr6YkfxcHzDs=;
 b=f8XcbMVPjBE5le46TmfH2fw2XmXPtmUkv3rovQp2mSokXlrmnwtvpTcOi1wFxrRcMTSjy8atdyrqcaNQLnlOwHZ45BMF+YEiBudj52HrQZu8GGyBi7dEG4XvlGqFQo0fUt8oIArOMBYrtI8zqfuO5k9lMBUmQjOsky8ZF0ANRAo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2271.namprd10.prod.outlook.com (2603:10b6:301:2f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:53:52 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 18:53:52 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 4/4] printk: Drop console_sem during panic
In-Reply-To: <Yfyl2TSdFmn7HqmV@google.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
 <20220201185802.98345-5-stephen.s.brennan@oracle.com>
 <Yfyl2TSdFmn7HqmV@google.com>
Date:   Fri, 04 Feb 2022 10:53:48 -0800
Message-ID: <87v8xuea4j.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 654c1b80-083b-46cc-f2e1-08d9e80faf9c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2271:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22716D81BF50424644A50CA0DB299@MWHPR1001MB2271.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4m1DLcY2vsDcbnd/OuJrOZ+g3PvwHjYD5gOcNGLWtbX88UQUMiYvSR6Ns3m1w0kJBHbKcUTG7tmXi3VAzGqgp2AC91cgkZWqRZamO1tpHg5qMXHBZRa48EU/qvpR8E/Pn/5Fc2QfJhs01zf71c/FgDwEhpYs8GVstkuMKFkR8d3eGiRrb57Y5LN7MW/F5emLeSV9OPM5JP+tB5kU2ea69tvv4ZWO0XtHQ4m28HIIuDBqJKlAq6BboiFsuT1GWtmeePRIBL2+0OHcs3Da5dkSaW+Zi3lALmx+t5RxmLgG79U5nmCPgXfQUiWqAfIYlCzBDnU3VwrVU7VcX6aIfN2kRWZGcoL2jETQMsNVZs66HdWwMkMVdOD5Vdw02AXFZAL/Ch3D2uYs159cwa6BNzeMQz9LFHoZv7xFjJICDAPYGXFErLGdhSRNvDlA65OKqnIlQqkY6CvvXNVgam3b4Bhb8DAXKDcH+x4RoOjSkX4EYYBQ086msr974hx75FyZYxX524sZ0/ughOneU2tbII9GkSi+SME+jqTtTHrgaMrf86cSp/ApGltHqkqzYi8CEPi6RRqcRywqs91pLhGoc8xLSO0qfWqyVus9NLmQtQkBy1B+2lEWbWM7Qg4IG0ONItTKLj3tRdIb/N5AoRPUH1CcTxjkVrfKVq6OMkJE3GuXbX+FegLFG9XySNAlwcSuG+y01lwq2SL/vr3yC5Qf5891gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66946007)(66556008)(4326008)(508600001)(6666004)(6512007)(8676002)(66476007)(38100700002)(26005)(38350700002)(8936002)(52116002)(186003)(6916009)(6486002)(86362001)(5660300002)(2906002)(83380400001)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74iZYwnqUQuKE4t3OdWkFbWpz4hgKxZB92bdanzKxWqE+Utc0zoJm2gR0qbm?=
 =?us-ascii?Q?mmy7XXVZTAKR7+SzUtpifXsxs/BaFbrGDw0khLQLcoHx+N/WjeUFSCGpt6uh?=
 =?us-ascii?Q?JQIKFvzI8RE60HZG5whNWVPNDPFPap0EwaQ6/9h+bALBlbmzD6sawK1xztwS?=
 =?us-ascii?Q?i4ZIJ4QPKVxaU1exnvRHXtN125PZhDEHhOE/IK6joPtwN95udSEuXv6NazUD?=
 =?us-ascii?Q?r5TGa0FToB4yyeTyxHaC6fbU5PoB5cg04oTRGiFXO2m4n921kk8X10sovURa?=
 =?us-ascii?Q?S6m1BgK6bE76plfK1H/+3LJo/IrSJYQbZensofs7IXcOkoFw+E/ChVOgsP2Q?=
 =?us-ascii?Q?gYzrSLkWQTqcQQRVTBx9xG8hkScLg5tFsTD5v9/9yxZtRREBpTlNn8dqi9/a?=
 =?us-ascii?Q?wsRVjYY2j+puJC40PBuYrSRKDeXVIHmR3PSlK2mXe+lF9XOk1dWNtGBzn94R?=
 =?us-ascii?Q?263NLLcZmGx70GueGhF4D9W+0Fu3j82Q8cCWWKZU1a3XcOZiQLmpl0SiSovz?=
 =?us-ascii?Q?mXsgekjpFLDgd8Dsk5SQpRFJiWysx2Qgo7SM2+deNsamQIlWlvgWAeFNUMyJ?=
 =?us-ascii?Q?/qnND5zeJBE/w7PXpjhu4VkvMBwLQ8sC65X2Y1M77qN6y8T+nd+C+yoO+pcA?=
 =?us-ascii?Q?pTO/Scjx7F3dOCXuBGVQijFRZQ2lVPVU3twxgXv7GEduiTsydSPZvHuCq5TE?=
 =?us-ascii?Q?tdVxjCO795Z2TckaWh3bIUsyymyMRt0OBdJfxqZx8wOEvaYlfIYEaTV9tIbb?=
 =?us-ascii?Q?Jq4Gk/mRbRVfc5/zVkx2LFhtDAgVAlesWACiz93RAVTCJqnFOQJ04n1/7ddU?=
 =?us-ascii?Q?prRs/GR+yMWL0bj0V3Y0lnkKL6lT2i3gOW7r/3YcZbzl38nQHOhtwrHmG1oA?=
 =?us-ascii?Q?jW5oJnOAkZTlCTiwCnS72yB3v2SXWsRaxgEhvDc84MtnR/MvdJHgsu/fk7lK?=
 =?us-ascii?Q?khi5THyAv+f/UqWySoeW+69DFz4x9eeZDQrpFSm9WqiWk1cF0nnZP9lEy8A1?=
 =?us-ascii?Q?EnXrQ+mQJ/F3YhQol/WaO5Lyp0m8uoOtmrZqT2EvpFGeezsGBs03XtwOrlsn?=
 =?us-ascii?Q?wYDkM3UbFfSfzzsLA90HOO/WKVEJmtKF6P5TaG2HBZs3JgRQsvfpX4vAvjL9?=
 =?us-ascii?Q?Zd4odkepDdHON7AJ2ett4cCqbzeTR5owaS6RgWQPDsIgvBIlDMPhLiQmV6UP?=
 =?us-ascii?Q?ldZGlHVVWhM0auxpw2sYix8iauknH+74Ad0ukRiUgm9YA5DjJMFSpegHT+XN?=
 =?us-ascii?Q?PuWVhI7Ga6Q7z6IV5L/bMopeYLnv+xF24HYmVgGckKMLQEnFZ8WLR+ltrYIq?=
 =?us-ascii?Q?L37M5PvVyoS75yRPTCKLmVn9fU29xUXi12TYAfg+d0dwPVc+a5rcFQVY4JvX?=
 =?us-ascii?Q?Y8ycRFC0V+qU37iNZ4ztYVfpwd+3Y3OboGLEkT08LztNQrTAtVpwNbKkhG/E?=
 =?us-ascii?Q?F/4OKadeN1y5EyCiG8NaYwRU/UpE7Tkvadb7xKdDMsm3DtB2uEtxDp/1NJFj?=
 =?us-ascii?Q?/M4aEvSlCjKppCuvNmaob6U3i8yB03SLgS+Wvyy744j4I4+PZCflODRqSt5h?=
 =?us-ascii?Q?EsXLkrVhQcZ+dbb+TNgnaye+JpLbPE9pcdQ2pXYpDH0i99lCvAmqucuDZIer?=
 =?us-ascii?Q?QkufxoeUjQCqtqBPMIiKYYvqyCW74rFmbt2XuyjlmnsOgAmmEyt5dzVPW3zo?=
 =?us-ascii?Q?7vKgKw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654c1b80-083b-46cc-f2e1-08d9e80faf9c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:53:52.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQM+09hT8pvUSrT7gUVy2zI1lEtmC7WTycix23cNWpw/JstfMeUU0OAiQQcO0XlZJ/uFewBLTR6xISvIvmc5hcEtEW0C5jhRqYNY0f9tXyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2271
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040103
X-Proofpoint-GUID: 9tE6lhJnoqz94Ito-e6BR9j7ODFEZ2FG
X-Proofpoint-ORIG-GUID: 9tE6lhJnoqz94Ito-e6BR9j7ODFEZ2FG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <senozhatsky@chromium.org> writes:
> On (22/02/01 10:58), Stephen Brennan wrote:
>> +/*
>> + * Return true when this CPU should unlock console_sem without pushing all
>> + * messages to the console. This reduces the chance that the console is
>> + * locked when the panic CPU tries to use it.
>> + */
>> +static bool abandon_console_lock_in_panic(void)
>> +{
>> +	if (!panic_in_progress())
>> +		return false;
>> +
>> +	/*
>> +	 * We can use raw_smp_processor_id() here because it is impossible for
>> +	 * the task to be migrated to the panic_cpu, or away from it. If
>> +	 * panic_cpu has already been set, and we're not currently executing on
>> +	 * that CPU, then we never will be.
>> +	 */
>> +	return atomic_read(&panic_cpu) != raw_smp_processor_id();
>> +}
>> +
>>  /*
>>   * Can we actually use the console at this time on this cpu?
>>   *
>> @@ -2746,6 +2765,10 @@ void console_unlock(void)
>>  		if (handover)
>>  			return;
>>  
>> +		/* Allow panic_cpu to take over the consoles safely */
>> +		if (abandon_console_lock_in_panic())
>> +			break;
>
> Sorry, why not just `return` like in handover case?

We need to drop console_sem before returning, since the whole benefit
here is to increase the chance that console_sem is unlocked when the
panic_cpu halts this CPU.

in the handover case, there's another cpu waiting, and we're essentially
transferring the console_sem ownership to that cpu, so we explicitly
return and skip the unlocking portion.

Does this need some comments to clarify it?

Admittedly if I had a few more lines of context in the diff, you would
see the console unlock directly after the loop; it's a bit clearer when
you're looking at the function as whole:

2768 		/* Allow panic_cpu to take over the consoles safely */
2769 		if (abandon_console_lock_in_panic())
2770 			break;
2771 
2772 		if (do_cond_resched)
2773 			cond_resched();
2774 	}
2775 
2776 	/* Get consistent value of the next-to-be-used sequence number. */
2777 	next_seq = console_seq;
2778 
2779 	console_locked = 0;
2780 	up_console_sem();

Stephen

>
>> +
>>  		if (do_cond_resched)
>>  			cond_resched();
>>  	}
>> @@ -2763,7 +2786,7 @@ void console_unlock(void)
>>  	 * flush, no worries.
>>  	 */
>>  	retry = prb_read_valid(prb, next_seq, NULL);
>> -	if (retry && console_trylock())
>> +	if (retry && !abandon_console_lock_in_panic() && console_trylock())
>>  		goto again;
>>  }
>>  EXPORT_SYMBOL(console_unlock);
