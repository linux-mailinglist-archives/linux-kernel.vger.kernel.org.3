Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF974BCEFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiBTOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:23:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiBTOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:23:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FA36E14;
        Sun, 20 Feb 2022 06:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj2oJssyShpvBoXIygXmVCsfbi36IiX7ssas7+xdSI0EdytvcmMo5Y/HqyDaa2tIRzHFrXrE0MHpzoZy4F0nTFPz0E4SINAdENVgLzXnODgQdh4u1vjsfquRW/0DNQ+2fxfFDvG2QWzvmXZNMoGs9NmMvRzvPYI8zRn1fbRmOOmR1HxDgd01Z+u1kh5bFQ52+A1TSNcmNnCOLNWmqGjXGCMkf9fg5MsQgUZPAI9M0cyaa0w9FEG2MRfRZv3bhws7fpm2qEB0ZMinIQ4CLz90Bi2hb1Nfd992AyGObJkynUwE/LiWLA7IoOWayr0486C02rLWz3hkX9FjTVIwy4wT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAEjeaVcobUctDRJ0Esb6uqWz386rigvyb1txDQgGT0=;
 b=nSRp2hgKMvQHPuMxaIvSAmw5PcZ0/k6p3G5YWRxstR8fLiQ1hgtUd9Pj5f3s8j80lJ0jMkO5gBh39yPbuicJApJFiXwY3zuu2p7oBcxiCJ/JZAacX98kI+Xk4amsJUEBefYC23LnuaKhlROUoxUFU/J6IuFq+6bB6jxtSprwlcRxPOpWyiZUT48KtlrNORQuU85IYG/0nKbYtogUhflqTE72tbolzdiJoZnRO26jscB09ej7qLSB3MWo+eTdisViqtgHadj2igoVv7CnlJGzoX5wH1pGWw+zhhr7MuoxwVYKcachdmlR5cR2PAPR9/hZDRjDnXcW/77Mv7NevPjHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAEjeaVcobUctDRJ0Esb6uqWz386rigvyb1txDQgGT0=;
 b=hu76toClo7kMkEkck/YtMGf8f7irPNFSzu4G4GsiZABvKbujqxqFcEkRwXdn+/v4yqLWb0hH0JL/+8LK/OaHx7s/Sci5j+UlZhqsJkWqw4X60UlLSv9KpGslrD4SgHz82G23NDmxRZuVSc4qg0O00uSXlrfDjZ3Hbnv+35Xl4bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Sun, 20 Feb 2022 14:23:21 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 14:23:21 +0000
Date:   Sun, 20 Feb 2022 22:22:57 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v6 4/9] cpupower: Add the function to get the
 sysfs value from specific table
Message-ID: <YhJOwWkPfsGJt84L@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-5-ray.huang@amd.com>
 <10708ac3-d33b-90b7-e096-14bccdfab942@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10708ac3-d33b-90b7-e096-14bccdfab942@linuxfoundation.org>
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db067790-1b26-4e5e-dde1-08d9f47c8c23
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33644FFA845895EF8801544CEC399@BN8PR12MB3364.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqJgk3/SF32K6/Qi+S0Vc284GS4OYgWBZ+qiRWT1t/Bz6fY3TWFRHiE+a9XmmUXeTNLBPCz5BNS2VNrgrZ+EDjjP0bEzvTFhC0lulkbSg+W+HhFLVQc/V+AQUOUd8lEBb+Lj7jNERxkF/rJ/crSyAv5Jbd2Lhp0UGfmMHUxJ5sXOdEvfEr8A1O/SMfyH/NMFjCWwAMNHVR/OlgkaKshYT2jjQ5GFcOkVbeumuIxphMgxxucmjgxUj8lfaPWsJvynVMO1pz7MrDH/FTIr47CAoNinXq6kKgh5COACBEaVD5Fh2uYmu7itbNh9O+dorcvIXnhDc6bz8x93hCitftJf7rlmlikHx/G7QGkQmF0ecAfR9c3ICgUrg3bbF/dGXQavssV1oAdSuPuelZDMAqKIJSrsTkVmYCAxdLBVO2VhtEo9+ID+doMGCJRmEpZz74OtwlcPA1oextiVFXrCoFzxwHN2MQvSj7TcPkUykhR+YJpzk/qaT8IoeSyYfuN6PKMeaMOv0UVof5qGJ9H21tp63a0kkhVf8jVF+KDaTHHx/2wb340VlFhgz9ZI7l1HzmRx2pBwULo7milA0YHDDf4ge+qF2DUcPIq0UeuP8defL0j2ZFAVRDLJ3tdWTpPfR5vT8iJCGRI0OxwtpTjXFJh4SLX4y4765z5hGA8Dff1WhuZRgQ1v2k91nsLheSBiYUvQOAX24VCABYgHsN4QfRE70A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(7416002)(86362001)(66946007)(8936002)(4326008)(38100700002)(5660300002)(316002)(66476007)(8676002)(83380400001)(6666004)(66556008)(2616005)(36756003)(53546011)(26005)(6506007)(186003)(6512007)(6486002)(508600001)(2906002)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JX2IlzNwATnp3D7Su3MdwUYNhUKM7Cc3HDc35T3b5QihUenOVwXfMnPWOR/z?=
 =?us-ascii?Q?C6SclfZeN31q8ARz6N5Aj2TGnzhFvpStPycUPEjlz5T81Kwbt8j1whKtb2Xc?=
 =?us-ascii?Q?QjdryMPQLvlIjG5zmDKzDq0F40lDOYq3KkLIvwRfZjLtQkE/IYttVzpKFGia?=
 =?us-ascii?Q?6IU2EBfRxmQ0oJ1+IHvtChd9Dz0xIOD+f+xwqRVU0khQMate0g03R6GFxPgQ?=
 =?us-ascii?Q?9XlzaoeXKB61c8k/CLffPCMAIa0MJ3EjOmdpe7SeCY/L2y91Nhv9JN1BeVqt?=
 =?us-ascii?Q?QJtaCk6NHl6HhHyySBG8XOH2JnaxcofC6m/pwDLD3PeYw88c/LfcZvRBGAUh?=
 =?us-ascii?Q?yRwI4+bY+5QhnHknh4kaX3tvRIlyCuNEC+Nk+vLcBQOCyy5X2G2V3vLBmMuI?=
 =?us-ascii?Q?9YNKAw++6fO55i8Llx4wNAxrGX6E3av7gPTjRf+HzQP5Hj9g2i8SlMnPEgHp?=
 =?us-ascii?Q?saNXlFDVsieIsFIeeyy8TXW9PkuZZROrkz5kudRVsxiXqx5wRIekOWwHWtjm?=
 =?us-ascii?Q?pMC304fsR08mveGjQMCDkkyrwO/MXnQaTo4qEUE1F1E97ZW+3Lm0EL09QjQ6?=
 =?us-ascii?Q?5psZofVMd41W0dCIvDxP+v0Xi+igQgnybfEX04iILEWOjCjYWLO4OXi9AqSM?=
 =?us-ascii?Q?KjFoZZK1ekA8d1Hn/N4s8kf1nmuEVbyleqnwZGjnIwEArnJlPUoOpW59b8yj?=
 =?us-ascii?Q?MzZQ29xSuoplQj2AZk7JZ5LSANCtIy7UnEvcuQb9JhDESdWci8xxSfa+UvQK?=
 =?us-ascii?Q?GsE56tHbMTjXxOhicVVdn6NK5u0JVBqD4bx+JLcMRzfLESScx2Da0sEWRLHt?=
 =?us-ascii?Q?GhuWqslUrlMM84TNWlqt2bYY2aVjFFKVdJE1cEdBDYcPFThf7lhnlFdQ0p+m?=
 =?us-ascii?Q?rSobSvwafLTvZSIecfqlQwnKNSr6z8xSQbZQemryD/y6SvkcuTtAvWkTBOtH?=
 =?us-ascii?Q?66aXzx8E5efWMS4Qh903qHwoIrx5KqdH6ACGboKrTpq5jFro5luhOmsL6o6E?=
 =?us-ascii?Q?mbZmjaF5WsvPJZP2Wy8wsmzM4mpAr4N7IzMI84ZiYZ6aPq+roe1nOiucOpcY?=
 =?us-ascii?Q?2q+It2JxNnPcuKvHXnAByHjrV+R235+M0zm6O26AYEuhje+ysM5x2jgIKsav?=
 =?us-ascii?Q?YlNd3QArG55UofltpPQLWOzxCzIIduhcDLdPXBkKJzis1/ml9MpITAuJydyn?=
 =?us-ascii?Q?04FzlPqy3vCnVvKQXqT0DJb/bRuagG/LDWvg38JOR1zm/BgO5VrJwl1J/2pM?=
 =?us-ascii?Q?2KuQsdCM/VWVavvZgNmNMeian/hzqhfu1On7VhRcIbvocUHd69GFu/WDZAt+?=
 =?us-ascii?Q?grb/Gquz4GFbw4IHE31laeaq8/C5QNDCpJfvHE8wyc/lqovHw0eto73vX7/z?=
 =?us-ascii?Q?lUFgOR8S14V1fr27G2axb38oBDn9UO/3zFNkF1/+UuroApGVdRuebYMnY0cp?=
 =?us-ascii?Q?Cn0fR1iBpEyBar2Zi5eXp6wqoBmXl9S8QR56R8ge9D1uqsgdLQfhzvRWSA6q?=
 =?us-ascii?Q?zCzd5D/2UAgWj8eLbYiFdlVJDHyf6DRmdnVWJNb9a8oRtkZGj9EWql1dw+vp?=
 =?us-ascii?Q?CuLHnA9/4Un9WmsCeb0unTel02LLODmquQe3q+0zKaxjmmxH+DxN2+L97iY/?=
 =?us-ascii?Q?LOrAAWoTXKeV3i+rHzAJXrY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db067790-1b26-4e5e-dde1-08d9f47c8c23
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 14:23:21.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2QHHIC56zM8nNcQj0fyvNlTYl8Awckqo+9xaf/Md8iqvGpizm30mY1aVktcRlQh8WxXTGscNOiE3BZyEhWRkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 07:46:46AM +0800, Shuah Khan wrote:
> On 2/16/22 12:35 AM, Huang Rui wrote:
> > Expose the helper into cpufreq header, then cpufreq driver can use this
> > function to get the sysfs value if it has any specific sysfs interfaces.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
> >   tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
> >   2 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > index c3b56db8b921..c011bca27041 100644
> > --- a/tools/power/cpupower/lib/cpufreq.c
> > +++ b/tools/power/cpupower/lib/cpufreq.c
> > @@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
> >   	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
> >   };
> >   
> > -
> > -static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> > -						 enum cpufreq_value which)
> > +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> > +						 const char **table,
> > +						 unsigned index,
> 
> unsigned int
> 
> > +						 unsigned size)
> 
> unsigned int
> 
> >   {
> >   	unsigned long value;
> >   	unsigned int len;
> >   	char linebuf[MAX_LINE_LEN];
> >   	char *endp;
> >   
> > -	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
> > +	if (!table || index >= size || !table[index])
> >   		return 0;
> >   
> > -	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
> > -				linebuf, sizeof(linebuf));
> > +	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
> > +				      sizeof(linebuf));
> >   
> >   	if (len == 0)
> >   		return 0;
> > @@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> >   	return value;
> >   }
> >   
> > +static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> > +						 enum cpufreq_value which)
> > +{
> > +	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
> > +						  which,
> > +						  MAX_CPUFREQ_VALUE_READ_FILES);
> > +}
> > +
> >   /* read access to files which contain one string */
> >   
> >   enum cpufreq_string {
> > diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> > index 95f4fd9e2656..107668c0c454 100644
> > --- a/tools/power/cpupower/lib/cpufreq.h
> > +++ b/tools/power/cpupower/lib/cpufreq.h
> > @@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
> >   int cpufreq_set_frequency(unsigned int cpu,
> >   				unsigned long target_frequency);
> >   
> > +/*
> > + * get the sysfs value from specific table
> > + *
> > + * Read the value with the sysfs file name from specific table. Does
> > + * only work if the cpufreq driver has the specific sysfs interfaces.
> > + */
> > +
> > +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> > +						 const char **table,
> > +						 unsigned index,
> 
> unsigned int?
> 
> > +						 unsigned size);
> 
> unsigned int?
> 

OK, the complier prefer 'unsigned int' to bare use of 'unsigned'. Thanks, I
will updated it in V7.

Thanks,
Ray
