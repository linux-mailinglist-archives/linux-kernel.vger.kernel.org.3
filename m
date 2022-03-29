Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401294EA77F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiC2FtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiC2FtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:49:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2824F23;
        Mon, 28 Mar 2022 22:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8A4l0/HQUKWUrbxaM4cZmry64y/dYpEyBjfltKSy6yQEcK99zRn0GtDtNBUYlPBC/KGBhs1Z3l5rJZ+LvIyAxo9NY/uWzW0ktpTHagNAwL2FZKYoRPBJ0gDuvz34YrxJSm+mkBnPZmGlWt4Lx9cMbeTzeNTClPTIupOevz2135YtRP+S99N8ywNaC9cMwo7ZY5gaZ0Y9AcY/Ly9rEXpuqEKuaTiFzv98wZ5C71uD/REv/R+/7jxU6Jqfnsc22Z46jkls2Pa3mDjGMdWqpWVaslRkEAmCvT91Dh9yKRCsVkV36/oNE3pnUZZRuiMkY2Te0SAXZeklP79NqMqNNkrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKM+YoI6Z1b0yXU2EhTIdKccmcfvUaf87lHuJ7VZttk=;
 b=bYL+AvV+hJvIOdd2XHRMZ1h7WPV4Yr7BHUb9+6IawU+0eRs7Y1rX2st3h7l1FEt7V5GOvhQ0zV/je4JfjIbXozR3DIQasi9aZdNhWbAEykIREsu3ZBqNM2CNH5t+tEbxNxhNswAS20FtHhJ0I0pBQkbP0Rdy92DMxwqmxxaFYaTEPFf7hYh6UtDF9kBWXOONvqI8wczpKf57CJuMrtL49lobog531raLqTQi1PsajmaMqjxNl8TszsSeUBUOog4BEvXsL6ngzu+wOeLQXpH6QDXWrXmI2R7p740X8gAHgiZapY/ZdeItCt7UObGKT0r33fbe0JLkpbYhhlgf5ZwwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKM+YoI6Z1b0yXU2EhTIdKccmcfvUaf87lHuJ7VZttk=;
 b=s90AvEayZzW7i9yGnnmyS3rBEocbO2vCYk1dF2A3WxpSGNwQFx/eaGgcjYKs60jMEsXYel4izDmYkQhwxTPm63pHpiMf+MPzQQsmmZun7MRh/lcwAueVh2fjND/aYqfHX80xXbr4haOboMWBQr0TGJ1Jpw3ZSCaRTXkp5/5Eauw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 05:47:35 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 05:47:35 +0000
Date:   Tue, 29 Mar 2022 13:47:15 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Export acpu_cpufreq_exit for other
 drivers to call
Message-ID: <YkKdY38OalxYw1Mn@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
 <20220329015947.565-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015947.565-2-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 601a7588-27a3-4544-f0c5-08da11479fe0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5339:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53396A3438090921EB72178AEC1E9@BN9PR12MB5339.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kp7VX0rGwMkcM3dg9lOBbtQwej1jYe0vm98aG1b1c8btBgaxfqJYQu5pd8n2+Gn7EBwt5oT1O28UCTr7ZFj+fbrz/BfcvBpnCNrMzYBhXEHcZHfNxp4dfwQt5VWmcfAoubniGMRzfVisuQtmgFgxQQNeHihyCAWAh/T9jy1sdEIgpC9ajWANqx9N1pu3KRK9fNfPuduKM0jtpBmXco9zZkDtTPueMzK95gWeGmyUT4c467IP4pYk4Ak9svNJILU0z1bGhMsBCmuXn4999ZrV9jF1C8Th+bfnEjHeYTMTI7C0oaBPPLaAFs8rVyB+baTYLZvAcFNQK4Aard7A3gkAy7OZLLux8XPBibI99t26lJD9mtlobuYFeO39EvNeqRBMkZUeaJonNkuwe/QleYMe7yjSqzmX3oo0WwicWJhlAZWLaiBBecPSH6bqwO//JkIO/uIWaffypYrOl4NJThKxRensM2iJsA6esVdMK981wIXyKUulQnFXLCJPIPt8HUxPlDfFo7YCKcRc3HJh3SaxSuqhVA6IwOJZG26H/aKGPSFJf6XfaD9NFJeJRFZSgJatqnWdkXVhvciMMrdqSka3Xa6yDah9HirDvIHKpO7mO59QtHFAsCNqL5YYIgx04Ha4QIvFvGuqU32/eu+aUes0TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(316002)(86362001)(186003)(66476007)(83380400001)(8676002)(66556008)(6666004)(4326008)(6862004)(2616005)(38100700002)(36756003)(26005)(6512007)(6636002)(6506007)(8936002)(6486002)(54906003)(5660300002)(37006003)(2906002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hna3ksmGCbbsZeh1MVVrqZydzhCOoWPES7APCLNnPQyhklfFIKijUaVYgTuH?=
 =?us-ascii?Q?MP4oaQyBHkj5Uvbf+HFCODnlVSYG0GXetaWujfxzsOmirtd9covJmAuNGUXT?=
 =?us-ascii?Q?JiFVjqXcHw14tV3JdrZm3aDM5Ify7Q9OxKHamBzkDblNCbZy5TudiHvPVrZI?=
 =?us-ascii?Q?8Hyr37KyST+CazHe1i4+PxAivgpHYe8EuRLl7v7++atkccBQUS0Szg8NErIb?=
 =?us-ascii?Q?Kz+yig0TIXtzg+OdPpc3BQzbvpIX+RIvKnTOLtGsBSEjKa8UdlFiwWjELnf9?=
 =?us-ascii?Q?oEHchfVNkjNSmd7uguKxRCyI2yKX2LIu4HCc//BYDscIuEP6pTFgRmzzRCzn?=
 =?us-ascii?Q?PQiXS2Ij2tAK9twrQjm3W7LmGi3FxoihZEFRb5frXDrTwKkAZRks8mJMDHzC?=
 =?us-ascii?Q?ri7XUzuX8ewMlP+Flh0cuCA/2ris0crM9gJPm8otbXKfZQ9SnUmctut6BXv1?=
 =?us-ascii?Q?+TGO8nDFMyJHDJPJCm+hzDDuFnmWGRHlLHUOnci0Xc9F2BHS6/JCQ6ha/13Z?=
 =?us-ascii?Q?H8hIEMkAq+1WfSEAs3HZZcSmjcHTvMtxaVZS3QvGsljF+rIcM1Up5SbYqiyW?=
 =?us-ascii?Q?++ZpcPX1a8PZ4i1X81qZNyt+uEN7rHJJymc7kALKANUxdv+Er6kTaWDUdZqu?=
 =?us-ascii?Q?cLlRFOAhKoVNpIHCf7h9dh/z6NH08mnXvnRSmKJapBxyYJ/oR33e2tCzCulL?=
 =?us-ascii?Q?Ue4lkO2cdo/qDlLFuZd/3PNdbmiQTiaPM7Y1OvkA8Viu33QKMFizNAAtKQda?=
 =?us-ascii?Q?R/NI7wsCRie/QXe/WvzP8VGxtqI7FdX1XmddqlbICERo6Uc0fQ2FcnX95m8h?=
 =?us-ascii?Q?lkPM+VpoA4J8JAuKHkCyRphfmRn0xtNwzdnysyFLMypQqW4NgEhrOchx/tpu?=
 =?us-ascii?Q?KcFQP6WqSNPRiyz3tTIqlwXF0Y600Y+8TRJEMI7ISP0MRwPHCJ3RW1KwuCmF?=
 =?us-ascii?Q?dEOMdK6lCW0sU/Bl2/2lkbtkzAKe/3ic5Cr0H+fFUiNkXIGgmO2e6aWe910v?=
 =?us-ascii?Q?k76wsG2SUyHXzy4/eN26FHQZ5L+J6RGFZ9rD3Aj8Aa5XHwG1ftn8vNHKdzMG?=
 =?us-ascii?Q?LXRQqMpiEjC/mABIoDAnsPafc5R0TfkBKW4RfJnZmC+GvkyMmjRfyiygRbiT?=
 =?us-ascii?Q?ZOgUMJLmYFrrlWRdaCk/Eid2kL9rZq5XDx8m98LO5ka6J04HPV9TxAx5G20R?=
 =?us-ascii?Q?cfqnLcLncydaPnHZGQnFHL7oGjOn11osmsJjawwLcSC7Nu4UlYXxIjKRS97v?=
 =?us-ascii?Q?d6fzt1m0Ntxib8HIO0IXi1F9/8NLgSTZh95USavV0e9l/PWSglPSppZYpPKA?=
 =?us-ascii?Q?gPzLh6MCvDl9dn6xUehCjLaza0EiDhXi70oRnkVj6Hf5BGhRIG4p1CPAAwBA?=
 =?us-ascii?Q?LB3RsKNzlpwJ/k3iseY2+GnwfVJEN8jAG+cMhDy+cSD4mhfWNxS29BoQJ1/J?=
 =?us-ascii?Q?o8PvfUo7rwHBBeJYJ+dpoIv+UbnzKFcILUnuJttvDqmMuEKDjgfu6zcDqJ4R?=
 =?us-ascii?Q?XjGCdzVIg6afz51ocQIQzkj5nTCEEcYR1vHkSy8odG2k8w2tvNvrQ1prWC9W?=
 =?us-ascii?Q?0vPpHnvFVBtUyfwiaYpCJNpqc7fcDakZGRRTkDqsacCs79iY8K1d0bn5or4d?=
 =?us-ascii?Q?5m72BRgP4joqKQ0JJjO4VF6kZTwXzjfdhbRX7CWY9Lbt5s9y6kBuYY7Xminb?=
 =?us-ascii?Q?utFyfAnU3yQ7oEw29j1GAzg3Le82kOykoQ1CmuyTETyzxtzllMSdnnIfUhH6?=
 =?us-ascii?Q?29d88eCytg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a7588-27a3-4544-f0c5-08da11479fe0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:47:35.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VIrijiRH5ZjNVs0q1n2Y6x7QJmFANuVANgdxAXm/N2DHKWkz1biXvkzvZOSvSaXSR659dtXvAUdNnECQRQHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:45AM +0800, Limonciello, Mario wrote:
> Currently, the only way to load an alternative cpufreq driver is to unload
> acpi-cpufreq first.
> 
> Loosen that restriction to allow other kernel modules to unregister a
> registered driver.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
> v1->v2:
>  * Export symbol instead of changing internals
> 
>  drivers/cpufreq/acpi-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 3d514b82d055..92ac978c1c53 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1033,7 +1033,7 @@ static int __init acpi_cpufreq_init(void)
>  	return ret;
>  }
>  
> -static void __exit acpi_cpufreq_exit(void)
> +void __exit acpi_cpufreq_exit(void)
>  {
>  	pr_debug("%s\n", __func__);
>  
> @@ -1043,6 +1043,7 @@ static void __exit acpi_cpufreq_exit(void)
>  
>  	free_acpi_perf_data();
>  }
> +EXPORT_SYMBOL_GPL(acpi_cpufreq_exit);
>  
>  module_param(acpi_pstate_strict, uint, 0644);
>  MODULE_PARM_DESC(acpi_pstate_strict,
> -- 
> 2.34.1
> 
