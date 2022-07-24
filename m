Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01257F3F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiGXILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGXILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:11:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28501658B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658650285; x=1690186285;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yf0oRE5Zkksg0W8cUHYJO4aqo9rAmXkAeOFlBbE/68M=;
  b=VChsmD3VUvcBxtBamVbsaJOUMNxl6MWYcUKtsWF+tCTJWm4oQstdckHm
   h1IitFRN7b29k7vFTec5+4Dt5UYbIBPNXc7SO4TBjvVXOKLmo5mKfGcFw
   8yfkpTec+Rs0tZq7u3slPtLRFFtTDSi7noI9wR1vellAN3xB3yWX9SPY5
   gtOQnS15hAypYslahdxXzhhNmMwCpAOHPYVPYMovKlX3kBiBjF9gpSaSc
   7LgqUKxIMkIAfk25vk1zx8mFh9Cu0d932fnycsMgd6fwEJ95mfCS7fhZB
   SeNYQd93f2z9gIVeqeyfXwyN2i0UvF6S09Y5WeuIjEdyEqzOI0QbqShB3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286284647"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="xz'?scan'208";a="286284647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="xz'?scan'208";a="667131634"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2022 01:11:24 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 24 Jul 2022 01:11:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 24 Jul 2022 01:11:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 24 Jul 2022 01:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtdoU/Y7cQFK+Uij3WCx2ZlLg6Gg8DQuOUcTasDsVb4NNGHyECOOJOclW9gnCfLlcOvVHUyDW+x8+Xvp92/y4PG/rcYGPpqQ3T4DUppW7jbLnOLX0wR+7G8Gr0FfZ8CuCuRjgH7jN4FnZ4pydy7eK0iI1qTkZ4r/gHN+MC1WzszZbZIwK09WgFCnEDRpGE1yW7au3La5742U+GQZ8l9h6D1hy9wRJEGYCcxDSDNnbrMsn7T2sENGx9hct1tE2js/77NTb9PlhBa1WNb+makSO7ixBN3bQaNiXQwGZs6FSOBEjekEpAlEIMXwtn9zh/HIPQ+k8se1712PQaLBxzv7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN4oVkzFGdwczEIYlD3nBS+iNvMUb/Dg+Hhh7YS5YhQ=;
 b=MdLf95sRe9a+Px85gnH3yoF2DG310xyI4yfVwLzVToAyT7mJav79xvPgjLSti+klRh9i3ehpT9DNTSkq9uaZ+EswAxQsBL9FNfeXFeVFmlxv41+eUaf7O4+7sKLCZtmbRmhBYGzv/iedtFe2Uwuev6ctaqX7WAXEJDz/bUc/98K18t/pKzviBywjoQ+h/FR4IkOB3foL9HbO6vkQHqIUHp2XFFvKcBQqivWkuYxfVtDJOC7D8bFIlbpHGa0yz5uFMvVBnX1MPA2U/tpynYFYJEY+AfsOD15+t8+YacErHrDMhr8JCoJqzV0YYXk8IDzlsCI41vcGxFRJi6rTIVoClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by MWHPR11MB1821.namprd11.prod.outlook.com (2603:10b6:300:10f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sun, 24 Jul
 2022 08:11:12 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.019; Sun, 24 Jul 2022
 08:11:11 +0000
Date:   Sun, 24 Jul 2022 16:11:02 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <aliyunlinux2-dev@linux.alibaba.com>, <jane.lv@intel.com>,
        <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>
Subject: [random]  3d1f971aa8:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <Ytz+lo4zRQYG3JUR@xsang-OptiPlex-9020>
Content-Type: multipart/mixed; boundary="snVoKl3TBKn/uiev"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 803bfea2-5212-4436-35ba-08da6d4c11d1
X-MS-TrafficTypeDiagnostic: MWHPR11MB1821:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLeIv/buJDr58jSJ4I7NQPqsYz0Rc1VSDrRYoZ2yKaU5LykEws/IDAk17Gq9nDl5z655mE/OZlyMjOWjcC8GNwpkmsM1xKu1BE75sW1lJPYsjEq3BwDngG7Ju1gniFjjMohdp6ULyu/x08bMYm/t1rHwHn27l24XBBx0TU9allu6niW1eYTiTiciXZ7cz4+ZD3qJDZwtcJiygAd2CKvqan4izJxAAC8gH7kziW2IhHSRCaMXFnvo9El/mhFMG/flYK+5sjQRWuGO7vFMG8CJqZ9VhkLy7Fc8aDPP7gmnnAqbR9huk9qOuMxBJMC1dUugBd1c3jKnT2RAKHVqkb6ObVjCP5ue4j7d+KMFHHOQ8ERue7kGlPvZWV/8xhAi7sU3Hmv9tRpC0BRGx+NsDBA73tWKcXb6ycuM1EICDeFRIRd5VA99zszbB+kiNim5BXbHSM30Tl1ikSEAgKx01LwUkMrOlFrOkxRLOqv781A7wqdYQkfxbUFa3Lcu8Ae1en0a4mYYW54boJdxTAQRtuKJLTZieJCPc6PSv0mB87b7MdkiGA+MilMoqvYbA9NxOmcg954E+Ma7MXAjtwpRLrw3k3uxTJzslW4NQTiJPsBBF2ll9+UXLLmNCv1ThGGBRFEEvotv1suo/3m/jubcPv/fo21vHIYR4X/K8MSwD96pxXyl7pZuSD+GEHCMDDbTqqxZ5gprA8GzF3PICk30NymDjFkuNJRNHbiw726C2Zm/bZQGtcCTgnMVd0NQA/eeMPlbQCH3XqHFjYjDrl881qmpzswqp/KTRfQi6EkRa/NUzZUq9Q0Yv1ibCAKlVNUvWTvnZjQB4TZyvq14guNsvyP//qOOqYExNBHeDvNvS4cpT+ncxzYuTg+XainAWPICHmbr8pD/W2+jagE6DbsVqFaemA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(376002)(366004)(346002)(39860400002)(235185007)(8936002)(5660300002)(966005)(478600001)(6486002)(26005)(6512007)(9686003)(86362001)(186003)(41300700001)(83380400001)(2906002)(6666004)(107886003)(6506007)(44144004)(38100700002)(82960400001)(6916009)(316002)(33716001)(66556008)(66946007)(4326008)(66476007)(8676002)(67856001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KEre3x9GSPYXmoxg5e7de2lWq6whaBN85BsqQ3xi/nMJUJnKvkx0ZOeXxtpR?=
 =?us-ascii?Q?V/0M84XHsnYnjUF/bx+BtyFGROCRey9OaBvGqBo22Lfil3KDbMVWPlInkMCh?=
 =?us-ascii?Q?vQgisL3JpQODDnPLbkjON/ZBSCqEqNVA/aqtGAYl3S+EmRAOt8JMHcoBRnAZ?=
 =?us-ascii?Q?iodccZk6NtkV4dv+NUQQJuoJmDyyuTelKltiqomltbr7YSkWECwifmgIXgnE?=
 =?us-ascii?Q?f3fz5MeNDEyDOnSK+n7zYp5zIWkPICP1HvcNHtqhTW31Mn9CNAFAmpHL0aea?=
 =?us-ascii?Q?5es1NDD1mL31YOhxoRm1nmP1oevAj05kEVgSaVhgC/cOwxAhz1IByu8cD387?=
 =?us-ascii?Q?l5QVxmTPXDaTzOlbFuucZiyaXxik1PrkZPEuQbPwyhWg+8sZfZFaU5LxkBB+?=
 =?us-ascii?Q?IhMLtJuraKnh74sjt+b4IV+wJbV1BQppp+f94m9s3DgzQ1iV1krejlOblEZs?=
 =?us-ascii?Q?SPmo8VPZkPErA5YE6O+DhQMZKM/Paxz/VbW7ESI5N1UfD52eticVpOEX3Kon?=
 =?us-ascii?Q?FpNAnoOoNKf5kxgN4Zci7tmdjJIo+bH+Hof7N19n6bCVb5RJd7TDuZOQTuO2?=
 =?us-ascii?Q?evUIl5v6QlamAvWtBtr+1J+UpgszaAQ0QHqEkbaYq5RBJWk46eIQnNQ55eo2?=
 =?us-ascii?Q?h2FaQ4FrO6LL8+fFyKX53hl77o4wG3t7b0/ryWSlAtK5wCfSObgkcUUh8NA2?=
 =?us-ascii?Q?Jriv3xeW+jGif+xsi9xuPfHq6MItWFE02z7v1S8RmPytuB8H07vf9iA/gOKk?=
 =?us-ascii?Q?zvZiUOJ9/oY6u/qigHbP2pA54q7ef+1gV0EPKIVqqH1WByH0e5TErFD0fAN9?=
 =?us-ascii?Q?wWa4nF+OZ/Y2ick6JWAXh1g2V71GmPH9dEi/7c70IxLt9ywFoyHA4aHqDONh?=
 =?us-ascii?Q?dtpOFQRJaVNYh5ow1rfzCB62T+E8exTNiq/PcpuqK5IzSPFydb4bLGkLkFKl?=
 =?us-ascii?Q?S96PgKY5YTzcyWB9eduVh8bWo+G4d8xXbYdb64L6c5kUFcsdJx4kvd2jbVsJ?=
 =?us-ascii?Q?3BZCFoOmpmkNmbmPeqbbdVH7y8mpP7HiCOHTOIsJW8G5KCsw3LPtBB4nv0L/?=
 =?us-ascii?Q?/gIqODKtgdZlpD053Ler2j9lvkMZFr8LOg+FtIxdXSpuPKPrVmR85Mtxr2So?=
 =?us-ascii?Q?PGiDHpoZSSdjagmJjQxkHtmU14Gb2lJGEryeO6rE/Fi1klB7O/4f+ljeRPUL?=
 =?us-ascii?Q?gwKMRcIvF8vMji3XKNr2+g9qRHnY876XIczEWUi9jiFonewrNxiGRQ7K6qCk?=
 =?us-ascii?Q?rVkpZuzBfXZbsNcbDaUCThA1Hthd0v8Y2vodCAzci+009KAWNUVvbvJxf+TL?=
 =?us-ascii?Q?Xxdo8xtyONnvNsj5Xm+HWC0cO0UT8W7S5zkGxRWMt1a21TjzK3IOGybbn6fJ?=
 =?us-ascii?Q?iQla1hhPI0qm6Q+L/U+PXpl8r94DQlMrqD8aNYW2qNL1laFElFmGfR/NU2rm?=
 =?us-ascii?Q?OEJ0LTwMIxmcWFRD1OcvYxjr70LkK2UwimRBRrdVo3SSbIodtTzcjDzAQqgA?=
 =?us-ascii?Q?vK7zC3tutEfhhfE9rcZMSsYZlH5IL6UuwGcwoHES526TRUe+UG1pMUldMYpL?=
 =?us-ascii?Q?H9OK50exy4waJEGfkWqoIAO5s2p3PolVmUSQxTGq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 803bfea2-5212-4436-35ba-08da6d4c11d1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2022 08:11:11.7241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29ZdCnbKbX2U3NO7iGwBMTT3qWh3DebYu8hsLLKqji5wtmcUP3K2+/lpA7ksKVVBs13n6tMbCGkKuaG9if2taw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--snVoKl3TBKn/uiev
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 3d1f971aa81f830d2c86a781960800ebb4347601 ("random: move initialization functions out of hot pages")
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y

in testcase: trinity
version: trinity-static-i386-x86_64-f93256fb_2019-08-28
with following parameters:

	runtime: 300s
	group: group-02

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   18.287691] WARNING: possible circular locking dependency detected
[   18.287692] 4.19.248-00165-g3d1f971aa81f #1 Not tainted
[   18.287693] ------------------------------------------------------
[   18.287712] stop/202 is trying to acquire lock:
[   18.287713] (ptrval) (console_owner){..-.}, at: console_unlock (??:?) 
[   18.287717]
[   18.287718] but task is already holding lock:
[   18.287718] (ptrval) (&(&port->lock)->rlock){-...}, at: pty_write (pty.c:?) 
[   18.287722]
[   18.287722] which lock already depends on the new lock.
[   18.287723]
[   18.287724]
[   18.287725] the existing dependency chain (in reverse order) is:
[   18.287725]
[   18.287726] -> #2 (&(&port->lock)->rlock){-...}:
[   18.287729] validate_chain+0x84a/0xe00 
[   18.287729] __lock_acquire (lockdep.c:?) 
[   18.287730] lock_acquire (??:?) 
[   18.287731] _raw_spin_lock_irqsave (??:?) 
[   18.287732] tty_port_tty_get (??:?) 
[   18.287733] tty_port_default_wakeup (tty_port.c:?) 
[   18.287734] tty_port_tty_wakeup (??:?) 
[   18.287734] uart_write_wakeup (??:?) 
[   18.287735] serial8250_tx_chars (??:?) 
[   18.287736] serial8250_handle_irq (??:?) 
[   18.287737] serial8250_default_handle_irq (8250_port.c:?) 
[   18.287738] serial8250_interrupt (8250_core.c:?) 
[   18.287738] __handle_irq_event_percpu (??:?) 
[   18.287739] handle_irq_event_percpu (??:?) 
[   18.287740] handle_irq_event (??:?) 
[   18.287741] handle_edge_irq (??:?) 
[   18.287742] handle_irq (??:?) 
[   18.287742] do_IRQ (??:?) 
[   18.287743] common_interrupt (entry_32.o:?) 
[   18.287744] _raw_spin_unlock_irqrestore (??:?) 
[   18.287745] uart_write (serial_core.c:?) 
[   18.287746] process_output_block (n_tty.c:?) 
[   18.287747] n_tty_write (n_tty.c:?) 
[   18.287747] tty_write (tty_io.c:?) 
[   18.287748] __vfs_write (??:?) 
[   18.287749] vfs_write (??:?) 
[   18.287750] ksys_write (??:?) 
[   18.287750] sys_write (??:?) 
[   18.287751] do_fast_syscall_32 (??:?) 
[   18.287752] entry_SYSENTER_32 (??:?) 
[   18.287752]
[   18.287753] -> #1 (&port_lock_key){-.-.}:
[   18.287756]
[   18.287756] -> #0 (console_owner){..-.}:
[   18.287759] check_prevs_add (lockdep.c:?) 
[   18.287760] validate_chain+0x84a/0xe00 
[   18.287761] __lock_acquire (lockdep.c:?) 
[   18.287761] lock_acquire (??:?) 
[   18.287762] console_unlock (??:?) 
[   18.287763] vprintk_emit (??:?) 
[   18.287764] vprintk_default (??:?) 
[   18.287764] vprintk_func (??:?) 
[   18.287765] printk (??:?) 
[   18.287766] get_random_u32 (??:?) 
[   18.287767] shuffle_freelist (slub.c:?) 
[   18.287767] allocate_slab (slub.c:?) 
[   18.287768] new_slab (slub.c:?) 
[   18.287769] ___slab_alloc+0x6d0/0xb20 
[   18.287770] __slab_alloc+0xd6/0x2e0 
[   18.287770] __kmalloc (??:?) 
[   18.287771] tty_buffer_alloc (tty_buffer.c:?) 
[   18.287772] __tty_buffer_request_room (tty_buffer.c:?) 
[   18.287773] tty_insert_flip_string_fixed_flag (??:?) 
[   18.287774] pty_write (pty.c:?) 
[   18.287775] process_output_block (n_tty.c:?) 
[   18.287776] n_tty_write (n_tty.c:?) 
[   18.287777] tty_write (tty_io.c:?) 
[   18.287778] __vfs_write (??:?) 
[   18.287779] vfs_write (??:?) 
[   18.287780] ksys_write (??:?) 
[   18.287780] sys_write (??:?) 
[   18.287781] do_fast_syscall_32 (??:?) 
[   18.287782] entry_SYSENTER_32 (??:?) 
[   18.287783]
[   18.287783] other info that might help us debug this:
[   18.287784]
[   18.287785] Chain exists of:
[   18.287785]   console_owner --> &port_lock_key --> &(&port->lock)->rlock
[   18.287789]
[   18.287790]  Possible unsafe locking scenario:
[   18.287790]
[   18.287791]        CPU0                    CPU1
[   18.287792]        ----                    ----
[   18.287792]   lock(&(&port->lock)->rlock);
[   18.287794]                                lock(&port_lock_key);
[   18.287814]                                lock(&(&port->lock)->rlock);
[   18.287815]   lock(console_owner);
[   18.287817]
[   18.287818]  *** DEADLOCK ***
[   18.287818]
[   18.287819] 6 locks held by stop/202:
[   18.287820] #0: (ptrval) (&tty->ldisc_sem){++++}, at: ldsem_down_read (??:?) 
[   18.287823] #1: (ptrval) (&tty->atomic_write_lock){+.+.}, at: tty_write_lock (tty_io.c:?) 
[   18.287826] #2: (ptrval) (&o_tty->termios_rwsem/1){++++}, at: n_tty_write (n_tty.c:?) 
[   18.287830] #3: (ptrval) (&ldata->output_lock){+.+.}, at: process_output_block (n_tty.c:?) 
[   18.287834] #4: (ptrval) (&(&port->lock)->rlock){-...}, at: pty_write (pty.c:?) 
[   18.287838] #5: (ptrval) (console_lock){+.+.}, at: console_trylock_spinning (printk.c:?) 
[   18.287841]
[   18.287842] stack backtrace:
[   18.287843] CPU: 0 PID: 202 Comm: stop Not tainted 4.19.248-00165-g3d1f971aa81f #1
[   18.287843] Call Trace:
[   18.287844] dump_stack (??:?) 
[   18.287845] print_circular_bug.cold+0x78/0x8b 
[   18.287846] check_prev_add+0x66a/0xd20 
[   18.287847] check_prevs_add (lockdep.c:?) 
[   18.287848] validate_chain+0x84a/0xe00 
[   18.287848] __lock_acquire (lockdep.c:?) 
[   18.287849] lock_acquire (??:?) 
[   18.287850] ? console_unlock (??:?) 
[   18.287851] console_unlock (??:?) 
[   18.287851] ? console_unlock (??:?) 
[   18.287852] ? native_save_fl (??:?) 
[   18.287853] vprintk_emit (??:?) 
[   18.287854] vprintk_default (??:?) 
[   18.287855] vprintk_func (??:?) 
[   18.287855] printk (??:?) 
[   18.287856] get_random_u32 (??:?) 
[   18.287857] ? shuffle_freelist (slub.c:?) 
[   18.287858] shuffle_freelist (slub.c:?) 
[   18.287858] ? page_address (??:?) 
[   18.287859] allocate_slab (slub.c:?) 
[   18.287860] new_slab (slub.c:?) 
[   18.287861] ? pvclock_clocksource_read (??:?) 
[   18.287862] ___slab_alloc+0x6d0/0xb20 
[   18.287862] ? kvm_sched_clock_read (kvmclock.c:?) 
[   18.287863] ? __slab_alloc+0xbc/0x2e0 
[   18.287864] ? native_wbinvd (paravirt.c:?) 
[   18.287865] __slab_alloc+0xd6/0x2e0 
[   18.287865] __kmalloc (??:?) 
[   18.287866] ? __lock_acquire (lockdep.c:?) 
[   18.287867] ? tty_buffer_alloc (tty_buffer.c:?) 
[   18.287868] tty_buffer_alloc (tty_buffer.c:?) 
[   18.287869] __tty_buffer_request_room (tty_buffer.c:?) 
[   18.287869] tty_insert_flip_string_fixed_flag (??:?) 
[   18.287870] pty_write (pty.c:?) 
[   18.287871] process_output_block (n_tty.c:?) 
[   18.287872] n_tty_write (n_tty.c:?) 
[   18.287873] ? print_dl_stats (??:?) 
[   18.287874] ? n_tty_ioctl (n_tty.c:?) 
[   18.287874] tty_write (tty_io.c:?) 
[   18.287875] ? n_tty_ioctl (n_tty.c:?) 
[   18.287876] ? tty_write_unlock (tty_io.c:?) 
[   18.287877] __vfs_write (??:?) 
[   18.287877] vfs_write (??:?) 
[   18.287878] ? __fget_light (file.c:?) 
[   18.287879] ksys_write (??:?) 


To reproduce:

        # build kernel
	cd linux
	cp config-4.19.248-00165-g3d1f971aa81f .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--snVoKl3TBKn/uiev
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-4.19.248-00165-g3d1f971aa81f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.248 Kernel Configuration
#

#
# Compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_TOSHIBA=y
# CONFIG_I8K is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_PMIC_OPREGION=y
# CONFIG_CRC_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=y
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_DEV_PATH_PARSER=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_PLUGIN_HOSTCC=""
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_PCI=y
CONFIG_MTD_PCMCIA=y
CONFIG_MTD_PCMCIA_ANONYMOUS=y
# CONFIG_MTD_GPIO_ADDR is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# CONFIG_MTD_LATCH_ADDR is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_M25P80 is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
# CONFIG_CS5535_CLOCK_EVENT_SRC is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
CONFIG_JOYSTICK_PXRC=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_AD714X_SPI=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_CPCAP_PWRBUTTON=y
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_ADXL34X_SPI=y
CONFIG_INPUT_IMS_PCU=y
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_HYPERV_KEYBOARD=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_APPLICOM=y
CONFIG_SONYPI=y

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD9571MWV is not set
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_DA9062_THERMAL=y
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_GEODE_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_TW5864=y
# CONFIG_VIDEO_TW68 is not set

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX18 is not set
CONFIG_VIDEO_CX25821=y
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET_CORE is not set
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_DM1105 is not set
# CONFIG_DVB_PT1 is not set
CONFIG_DVB_PT3=y
# CONFIG_MANTIS_CORE is not set
CONFIG_DVB_NGENE=y
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
CONFIG_VIDEO_IPU3_CIO2=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SI470X=y
CONFIG_USB_SI470X=y
CONFIG_I2C_SI470X=y
CONFIG_RADIO_SI4713=y
# CONFIG_USB_SI4713 is not set
CONFIG_PLATFORM_SI4713=y
CONFIG_I2C_SI4713=y
CONFIG_USB_MR800=y
CONFIG_USB_DSBR=y
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
CONFIG_USB_MA901=y
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_VIDEO_TVEEPROM=y
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV748X=y
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9807_VCM=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_NOON010PC30=y
CONFIG_VIDEO_M5MOLS=y
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_S5C73M3=y

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_I2C is not set

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
# CONFIG_MEDIA_TUNER_TDA9887 is not set
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MSI001=y
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
# CONFIG_MEDIA_TUNER_XC4000 is not set
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_TDA18271C2DD=y
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
# CONFIG_DVB_SI21XX is not set
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_DS3000 is not set
CONFIG_DVB_MB86A16=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
# CONFIG_DVB_ZL10353 is not set
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
CONFIG_DVB_MN88443X=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=y
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=y
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
# CONFIG_DRM_NXP_PTN3460 is not set
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_I810=y
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_I810=y
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
CONFIG_FB_GEODE_GX=y
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_HYPERV=y
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_APPLE=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_OT200 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_HYPERV_MOUSE=y
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_SL811_CS is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=y
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_ACPI=y
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_USB_ULPI_BUS=y
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=y
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_SPI=y
CONFIG_MMC_SDRICOH_CS=y
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
CONFIG_EDAC_E7XXX=y
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_UIO_HV_GENERIC=y
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_BALLOON is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
CONFIG_DELL_WMI_AIO=y
CONFIG_DELL_WMI_LED=y
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
# CONFIG_TC1100_WMI is not set
CONFIG_HP_ACCEL=y
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=y
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SENSORS_HDAPS=y
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=y
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=y
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=y
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_APPLE_GMUX=y
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set

#
# VME Device Drivers
#
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CRC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_RAVE_SP_EEPROM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
# CONFIG_FSI_SBEFIFO is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=m
CONFIG_UCS2_STRING=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y

--snVoKl3TBKn/uiev
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-stable-rc/linux-4.19.y'
	export commit='3d1f971aa81f830d2c86a781960800ebb4347601'
	export kconfig='i386-randconfig-r036-20220718'
	export repeat_to=12
	export nr_vm=160
	export submit_id='62dad852f1d4940d5b11c86d'
	export job_file='/lkp/jobs/scheduled/vm-meta-243/trinity-group-02-300s-quantal-i386-core-20190426.cgz-3d1f971aa81f830d2c86a781960800ebb4347601-20220723-68955-1po05cy-11.yaml'
	export id='4b34fca07e298a3de6f5693e127bf0e4ac99035c'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='quantal-i386-core-20190426.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-07-23 01:03:15 +0800'
	export _id='62dad853f1d4940d5b11c872'
	export _rt='/result/trinity/group-02-300s/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-02-300s/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601/8'
	export scheduler_version='/lkp/lkp/.src-20220722-141741'
	export arch='i386'
	export max_uptime=2100
	export initrd='/osimage/quantal/quantal-i386-core-20190426.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-02-300s/vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601/8
BOOT_IMAGE=/pkg/linux/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601/vmlinuz-4.19.248-00165-g3d1f971aa81f
branch=linux-stable-rc/linux-4.19.y
job=/lkp/jobs/scheduled/vm-meta-243/trinity-group-02-300s-quantal-i386-core-20190426.cgz-3d1f971aa81f830d2c86a781960800ebb4347601-20220723-68955-1po05cy-11.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-r036-20220718
commit=3d1f971aa81f830d2c86a781960800ebb4347601
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601/modules.cgz'
	export bm_initrd='/osimage/pkg/quantal-i386-core.cgz/trinity-static-i386-x86_64-f93256fb_2019-08-28.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export stop_repeat_if_found='dmesg.EIP:_raw_spin_unlock_irqrestore'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export meta_host='vm-meta-243'
	export kernel='/pkg/linux/i386-randconfig-r036-20220718/gcc-11/3d1f971aa81f830d2c86a781960800ebb4347601/vmlinuz-4.19.248-00165-g3d1f971aa81f'
	export dequeue_time='2022-07-23 01:03:54 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-243/trinity-group-02-300s-quantal-i386-core-20190426.cgz-3d1f971aa81f830d2c86a781960800ebb4347601-20220723-68955-1po05cy-11.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-02' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--snVoKl3TBKn/uiev
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAABFla

--snVoKl3TBKn/uiev
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="trinity"

Seeding trinity by 3904349311 based on vm-snb/quantal-i386-core-20190426.cgz/i386-randconfig-r036-20220718
2022-07-22 17:05:44 chroot --userspec nobody:nogroup / trinity -q -q -l off -s 3904349311 -N 999999999 -c accept4 -c chown -c connect -c copy_file_range -c dup2 -c epoll_pwait -c epoll_wait -c eventfd -c exit -c exit_group -c fchdir -c fcntl -c fgetxattr -c fsopen -c fstatfs64 -c fsync -c ftruncate -c getgid -c getpeername -c getpriority -c getsockname -c gettimeofday -c init_module -c io_getevents -c ioprio_get -c ioprio_set -c lgetxattr -c link -c listen -c llistxattr -c lremovexattr -c lseek -c mlockall -c munlock -c newlstat -c nice -c olduname -c openat -c personality -c poll -c read -c removexattr -c sched_get_priority_min -c sched_getattr -c sched_setaffinity -c seccomp -c set_tid_address -c setregid16 -c shmat -c sigsuspend -c socketcall -c statx -c syslog -c timer_delete -c timerfd_gettime -c unlinkat -c unshare -c waitid -c write
Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
shm:0x374e1000-0x43c8de14 (4 pages)
[main] Marking syscall accept4 (364) as to be enabled.
[main] Marking syscall chown (182) as to be enabled.
[main] Marking syscall connect (362) as to be enabled.
[main] Marking syscall copy_file_range (377) as to be enabled.
[main] Marking syscall dup2 (63) as to be enabled.
[main] Marking syscall epoll_pwait (319) as to be enabled.
[main] Marking syscall epoll_wait (256) as to be enabled.
[main] Marking syscall eventfd (323) as to be enabled.
[main] exit is marked as AVOID. Skipping
[main] Marking syscall exit (1) as to be enabled.
[main] exit_group is marked as AVOID. Skipping
[main] Marking syscall exit_group (252) as to be enabled.
[main] Marking syscall fchdir (133) as to be enabled.
[main] Marking syscall fcntl (55) as to be enabled.
[main] Marking syscall fgetxattr (231) as to be enabled.
[main] Marking syscall fsopen (423) as to be enabled.
[main] Marking syscall fstatfs64 (269) as to be enabled.
[main] Marking syscall fsync (118) as to be enabled.
[main] Marking syscall ftruncate (93) as to be enabled.
[main] Marking syscall getgid (200) as to be enabled.
[main] Marking syscall getpeername (368) as to be enabled.
[main] Marking syscall getpriority (96) as to be enabled.
[main] Marking syscall getsockname (367) as to be enabled.
[main] Marking syscall gettimeofday (78) as to be enabled.
[main] Marking syscall init_module (128) as to be enabled.
[main] Marking syscall io_getevents (247) as to be enabled.
[main] Marking syscall ioprio_get (290) as to be enabled.
[main] Marking syscall ioprio_set (289) as to be enabled.
[main] Marking syscall lgetxattr (230) as to be enabled.
[main] Marking syscall link (9) as to be enabled.
[main] Marking syscall listen (363) as to be enabled.
[main] Marking syscall llistxattr (233) as to be enabled.
[main] Marking syscall lremovexattr (236) as to be enabled.
[main] Marking syscall lseek (19) as to be enabled.
[main] Marking syscall mlockall (152) as to be enabled.
[main] Marking syscall munlock (151) as to be enabled.
[main] Marking syscall newlstat (107) as to be enabled.
[main] Marking syscall nice (34) as to be enabled.
[main] Marking syscall olduname (59) as to be enabled.
[main] Marking syscall openat (295) as to be enabled.
[main] Marking syscall personality (136) as to be enabled.
[main] Marking syscall poll (168) as to be enabled.
[main] Marking syscall read (3) as to be enabled.
[main] Marking syscall removexattr (235) as to be enabled.
[main] Marking syscall sched_get_priority_min (160) as to be enabled.
[main] Marking syscall sched_getattr (352) as to be enabled.
[main] Marking syscall sched_setaffinity (241) as to be enabled.
[main] Marking syscall seccomp (354) as to be enabled.
[main] set_tid_address is marked as AVOID. Skipping
[main] Marking syscall set_tid_address (258) as to be enabled.
[main] Marking syscall setregid16 (71) as to be enabled.
[main] Marking syscall shmat (391) as to be enabled.
[main] sigsuspend is marked as AVOID. Skipping
[main] Marking syscall sigsuspend (72) as to be enabled.
[main] Marking syscall socketcall (102) as to be enabled.
[main] Marking syscall statx (383) as to be enabled.
[main] Marking syscall syslog (103) as to be enabled.
[main] Marking syscall timer_delete (263) as to be enabled.
[main] Marking syscall timerfd_gettime (326) as to be enabled.
[main] Marking syscall unlinkat (301) as to be enabled.
[main] Marking syscall unshare (310) as to be enabled.
[main] Marking syscall waitid (284) as to be enabled.
[main] Marking syscall write (4) as to be enabled.
[main] Couldn't chmod tmp/ to 0777.
[main] Using user passed random seed: 2147483647.
[main] Enabled 59 syscalls. Disabled 370 syscalls.
[main] Using pid_max = 4096
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] futex: 0 owner:0
[main] Reserved/initialized 5 futexes.
[main] sysv_shm: id:0 size:40960 flags:7b0 ptr:(nil)
[main] sysv_shm: id:32769 size:32768 flags:17b0 ptr:(nil)
[main] Added 16 filenames from /dev
[main] Added 14623 filenames from /proc
[main] Added 5337 filenames from /sys
Can't do protocol ECONET
[main] Couldn't open socket (36:3:5). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
Can't do protocol KEY
[main] Couldn't open socket (10:5:132). Socket type not supported
Can't do protocol UNSPEC
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
Can't do protocol WANPIPE
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
Can't do protocol PACKET
Can't do protocol SNA
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (27:2:5). Address family not supported by protocol
[main] Couldn't open socket (5:3:0). Address family not supported by protocol
Can't do protocol SECURITY
[main] Couldn't open socket (4:2:0). Address family not supported by protocol
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (23:1:0). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
Can't do protocol SNA
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (38:5:0). Address family not supported by protocol
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
Can't do protocol WANPIPE
[main] Couldn't open socket (37:5:3). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (27:2:2). Address family not supported by protocol
Can't do protocol SNA
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
Can't do protocol ASH
[main] Couldn't open socket (4:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:1). Address family not supported by protocol
Can't do protocol BRIDGE
[main] Couldn't open socket (11:2:1). Address family not supported by protocol
[main] Couldn't open socket (11:2:4). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (44:3:0). Address family not supported by protocol
[main] Couldn't open socket (24:2:2). Address family not supported by protocol
[main] Couldn't open socket (44:3:0). Address family not supported by protocol
[main] Couldn't open socket (41:10:0). Address family not supported by protocol
[main] Couldn't open socket (29:2:2). Address family not supported by protocol
[main] Couldn't open socket (40:2:4). Address family not supported by protocol
Can't do protocol ASH
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
Can't do protocol UNSPEC
[main] Couldn't open socket (16:3:7). Protocol not supported
Can't do protocol ASH
Can't do protocol LLC
[main] Couldn't open socket (12:5:2). Address family not supported by protocol
[main] Couldn't open socket (27:5:2). Address family not supported by protocol
[main] Couldn't open socket (24:9:2). Address family not supported by protocol
[main] Couldn't open socket (41:2:0). Address family not supported by protocol
[main] Couldn't open socket (16:2:21). Protocol not supported
[main] Couldn't open socket (28:2:6). Address family not supported by protocol
[main] Couldn't open socket (35:2:1). Address family not supported by protocol
Can't do protocol BRIDGE
[main] Couldn't open socket (38:5:0). Address family not supported by protocol
[main] Couldn't open socket (3:2:0). Address family not supported by protocol
[main] Couldn't open socket (4:2:0). Address family not supported by protocol
[main] Couldn't open socket (23:2:0). Address family not supported by protocol
[main] Couldn't open socket (6:5:0). Address family not supported by protocol
[main] Couldn't open socket (37:5:3). Address family not supported by protocol
[main] Couldn't open socket (33:2:2). Address family not supported by protocol
[main] Couldn't open socket (11:2:3). Address family not supported by protocol
[main] Couldn't open socket (39:3:1). Address family not supported by protocol
[main] Couldn't open socket (37:1:4). Address family not supported by protocol
[main] Couldn't open socket (44:3:0). Address family not supported by protocol
[main] Couldn't open socket (12:1:2). Address family not supported by protocol
[main] Couldn't open socket (39:2:1). Address family not supported by protocol
[main] Couldn't open socket (2:5:0). Socket type not supported
[main] Couldn't open socket (3:5:1). Address family not supported by protocol
[main] Couldn't open socket (39:2:1). Address family not supported by protocol
[main] Couldn't open socket (30:1:0). Address family not supported by protocol
[main] Couldn't open socket (20:2:0). Address family not supported by protocol
[main] Couldn't open socket (8:2:0). Address family not supported by protocol
Can't do protocol PACKET
[main] Couldn't open socket (21:5:0). Address family not supported by protocol
[main] Couldn't open socket (27:5:3). Address family not supported by protocol
[main] Enabled 14/14 fd providers. initialized:14.
[main] Error opening tracing_on : Permission denied
[main] 13422 iterations. [F:7903 S:5515 HI:6841]
[main] 37320 iterations. [F:22047 S:15269 HI:14834]
[main] 58831 iterations. [F:35275 S:23555 HI:21979]
[main] 76320 iterations. [F:46297 S:30020 HI:27809]
[main] 90669 iterations. [F:55394 S:35272 HI:32608]
[main] 105048 iterations. [F:64493 S:40551 HI:37430]
[main] 122763 iterations. [F:75809 S:46952 HI:43310]
[main] 137051 iterations. [F:84897 S:52150 HI:47946]
[main] 151290 iterations. [F:93921 S:57366 HI:52792]
[main] 166938 iterations. [F:103923 S:63012 HI:58046]
[main] 182384 iterations. [F:113780 S:68600 HI:63212]
[main] 197395 iterations. [F:123312 S:74080 HI:68264]
[main] 210462 iterations. [F:131562 S:78896 HI:72590]
[main] 233165 iterations. [F:146040 S:87123 HI:80179]
[main] 256789 iterations. [F:160993 S:95792 HI:87988]
[main] 280910 iterations. [F:176373 S:104534 HI:95955]
[main] 306745 iterations. [F:193248 S:113494 HI:104553]
[main] 330420 iterations. [F:208800 S:121618 HI:112433]
[main] 357507 iterations. [F:226403 S:131101 HI:121489]
[main] 381250 iterations. [F:241999 S:139248 HI:129429]
[main] 407451 iterations. [F:259006 S:148441 HI:138188]
[main] 431331 iterations. [F:274703 S:156626 HI:146123]
[main] 453557 iterations. [F:289198 S:164356 HI:153605]
[main] 476591 iterations. [F:304214 S:172374 HI:161245]
[main] 494338 iterations. [F:315703 S:178633 HI:167194]
[main] 512895 iterations. [F:327822 S:185070 HI:173358]
[main] 530343 iterations. [F:339184 S:191156 HI:179267]
[main] 548566 iterations. [F:351044 S:197519 HI:185374]
[main] 566530 iterations. [F:362657 S:203869 HI:191357]
[main] 587665 iterations. [F:376397 S:211265 HI:198418 STALLED:1]
[main] 606137 iterations. [F:388266 S:217868 HI:203015]
[main] 624523 iterations. [F:400130 S:224390 HI:207671]
[main] 643762 iterations. [F:412543 S:231215 HI:212452]
[main] 665590 iterations. [F:426762 S:238823 HI:217976]
[main] 689940 iterations. [F:442675 S:247262 HI:224051]
[main] 714062 iterations. [F:458397 S:255660 HI:229996]
[main] 738779 iterations. [F:474436 S:264339 HI:236159]
[main] 764929 iterations. [F:491585 S:273339 HI:242698]
[main] 786796 iterations. [F:506000 S:280793 HI:248193]
[main] 811132 iterations. [F:521884 S:289244 HI:254385]
[main] 834390 iterations. [F:537025 S:297360 HI:260202]
[main] 857251 iterations. [F:552078 S:305169 HI:265951]
[main] 878903 iterations. [F:566150 S:312750 HI:271328]
[main] 902593 iterations. [F:581673 S:320918 HI:277383]
[main] 919374 iterations. [F:592635 S:326735 HI:281592]
[main] 935481 iterations. [F:603184 S:332294 HI:285622]
[main] 951806 iterations. [F:613837 S:337964 HI:289718]
[main] 967946 iterations. [F:624313 S:343630 HI:293754]
[main] 985969 iterations. [F:636026 S:349941 HI:298303]
[main] 1001782 iterations. [F:646439 S:355339 HI:302254]
[main] 1017652 iterations. [F:656877 S:360772 HI:306218]
[main] 1034473 iterations. [F:667986 S:366483 HI:310496]
[main] 1048963 iterations. [F:677537 S:371421 HI:314134]
[main] 1066202 iterations. [F:688659 S:377539 HI:318434]
[main] 1089682 iterations. [F:703954 S:385724 HI:324250]
[main] 1114476 iterations. [F:720128 S:394345 HI:330426]
[main] 1138718 iterations. [F:735955 S:402761 HI:336507]
[main] 1161028 iterations. [F:750539 S:410487 HI:342149]
[main] 1184326 iterations. [F:765737 S:418585 HI:348030]
[main] 1207242 iterations. [F:780694 S:426546 HI:353846]
[main] 1229930 iterations. [F:795491 S:434435 HI:359594]
[main] 1253327 iterations. [F:810707 S:442617 HI:365430]
[main] 1276402 iterations. [F:825607 S:450790 HI:371221]
[main] 1301277 iterations. [F:842015 S:459258 HI:377391]
[main] 1323027 iterations. [F:856168 S:466854 HI:382813]
[main] 1341387 iterations. [F:868202 S:473183 HI:387391]
[main] 1359699 iterations. [F:880136 S:479558 HI:391960]
[main] 1378530 iterations. [F:892477 S:486051 HI:396699]
[main] 1399799 iterations. [F:906457 S:493338 HI:402006]
[main] 1418483 iterations. [F:918541 S:499939 HI:406636]
[main] 1437326 iterations. [F:930842 S:506479 HI:411415]
[main] 1455918 iterations. [F:942917 S:512997 HI:416064]
[main] 1472345 iterations. [F:953631 S:518709 HI:420227]
[main] 1490450 iterations. [F:965506 S:524941 HI:424782]
[main] 1509075 iterations. [F:977645 S:531426 HI:429455]
[main] 1530603 iterations. [F:991699 S:538901 HI:434823]
[main] 1551970 iterations. [F:1005696 S:546270 HI:440223]
[main] 1573142 iterations. [F:1019602 S:553536 HI:445439]
[main] 1594201 iterations. [F:1033269 S:560929 HI:450674]
[main] 1617115 iterations. [F:1048448 S:568662 HI:456419]
[main] 1640130 iterations. [F:1063426 S:576699 HI:462201]
[main] 1660827 iterations. [F:1076900 S:583925 HI:467454]
[main] 1681836 iterations. [F:1090666 S:591167 HI:472788]
[main] 1702057 iterations. [F:1103993 S:598063 HI:477910]
[main] 1723404 iterations. [F:1118048 S:605352 HI:483260]
[main] 1739930 iterations. [F:1128845 S:611081 HI:487344]
[main] 1755740 iterations. [F:1139187 S:616549 HI:491274]
[main] 1770077 iterations. [F:1148505 S:621568 HI:494845]
[main] 1784756 iterations. [F:1158160 S:626591 HI:498377]
[main] 1801393 iterations. [F:1169060 S:632329 HI:502552]
[main] 1818065 iterations. [F:1179878 S:638183 HI:506778]
[main] 1832850 iterations. [F:1189487 S:643360 HI:510465]
[main] 1847113 iterations. [F:1198720 S:648388 HI:514023]
[main] 1866931 iterations. [F:1211667 S:655260 HI:518974]
[main] 1884827 iterations. [F:1223381 S:661443 HI:523461]
[main] 1909652 iterations. [F:1239585 S:670064 HI:529750]
[main] 1931250 iterations. [F:1253628 S:677619 HI:535137]
[main] 1953961 iterations. [F:1268408 S:685549 HI:540855]
[main] 1976534 iterations. [F:1283177 S:693352 HI:546463]
[main] 2000476 iterations. [F:1298896 S:701577 HI:552421]
[main] 2022345 iterations. [F:1313164 S:709176 HI:557883]
[main] 2044338 iterations. [F:1327557 S:716778 HI:563401]
[main] 2069195 iterations. [F:1343736 S:725456 HI:569663]
[main] 2092376 iterations. [F:1358935 S:733437 HI:575603]
[main] 2116114 iterations. [F:1374327 S:741784 HI:581657]
[main] 2137497 iterations. [F:1388388 S:749105 HI:587046]
[main] 2155660 iterations. [F:1400131 S:755525 HI:591638]
[main] 2175679 iterations. [F:1413255 S:762420 HI:596638]
[main] 2195973 iterations. [F:1426456 S:769512 HI:601713]
[main] 2215012 iterations. [F:1438937 S:776070 HI:606585]
[main] 2234032 iterations. [F:1451257 S:782770 HI:611338]
[main] 2253312 iterations. [F:1463965 S:789342 HI:616154]
[main] 2270269 iterations. [F:1474990 S:795274 HI:620446]
[main] 2289323 iterations. [F:1487397 S:801921 HI:625285]
[main] 2307218 iterations. [F:1498961 S:808255 HI:629737]
[main] 2326851 iterations. [F:1511909 S:814937 HI:634616]
[main] 2348633 iterations. [F:1526151 S:822478 HI:640073]
[main] 2371611 iterations. [F:1541189 S:830420 HI:645891]
[main] 2398428 iterations. [F:1558717 S:839707 HI:652652]
[main] 2421168 iterations. [F:1573569 S:847595 HI:658329]
[main] 2445494 iterations. [F:1589440 S:856050 HI:664389]
[main] 2470911 iterations. [F:1605973 S:864934 HI:670828]
[main] 2492768 iterations. [F:1620239 S:872525 HI:676256]
[main] 2515312 iterations. [F:1635004 S:880303 HI:681852]
[main] 2540596 iterations. [F:1651480 S:889113 HI:688110]
[main] 2567653 iterations. [F:1669272 S:898376 HI:694932]
[main] 2584983 iterations. [F:1680534 S:904446 HI:699354]
[main] 2601092 iterations. [F:1691042 S:910046 HI:703386]
[main] 2616695 iterations. [F:1701224 S:915469 HI:707297]
[main] 2633790 iterations. [F:1712292 S:921495 HI:711601]
[main] 2648337 iterations. [F:1721800 S:926534 HI:715231]
[main] 2664254 iterations. [F:1732195 S:932056 HI:719290]
[main] 2678450 iterations. [F:1741339 S:937107 HI:722878]
[main] 2693567 iterations. [F:1751196 S:942367 HI:726661]
[main] 2707914 iterations. [F:1760516 S:947396 HI:730302]
[main] 2723777 iterations. [F:1770823 S:952951 HI:734251]
[main] 2746480 iterations. [F:1785643 S:960832 HI:739944]
[main] 2768695 iterations. [F:1800098 S:968593 HI:745514]
[main] 2792536 iterations. [F:1815595 S:976938 HI:751426]
[main] 2815126 iterations. [F:1830504 S:984617 HI:757139]
[main] 2837919 iterations. [F:1845345 S:992570 HI:762810]
[main] 2859609 iterations. [F:1859451 S:1000153 HI:768225]
[main] 2885011 iterations. [F:1875985 S:1009021 HI:774590]
[main] 2910398 iterations. [F:1892600 S:1017794 HI:781090]
[main] 2932466 iterations. [F:1906911 S:1025551 HI:786559]
[main] 2957750 iterations. [F:1923403 S:1034344 HI:792915]
[main] 2980847 iterations. [F:1938449 S:1042394 HI:798776]
[main] 3001791 iterations. [F:1952058 S:1049729 HI:804039]
[main] 3024541 iterations. [F:1966824 S:1057713 HI:809763]
[main] 3043429 iterations. [F:1979182 S:1064244 HI:814504]
[main] 3060071 iterations. [F:1990120 S:1069947 HI:818652]
[main] 3081160 iterations. [F:2003937 S:1077219 HI:823959]
[main] 3099389 iterations. [F:2015820 S:1083566 HI:828580]
[main] 3120579 iterations. [F:2029605 S:1090969 HI:833868]
[main] 3140077 iterations. [F:2042332 S:1097740 HI:838733]
[main] 3159904 iterations. [F:2055271 S:1104628 HI:843700]
[main] 3183266 iterations. [F:2070450 S:1112813 HI:849545]
[main] 3207656 iterations. [F:2086444 S:1121207 HI:855559]
[main] 3232230 iterations. [F:2102479 S:1129748 HI:861767]
[main] 3258242 iterations. [F:2119525 S:1138715 HI:868322]
[main] 3284376 iterations. [F:2136573 S:1147800 HI:874744]
[main] 3312955 iterations. [F:2155407 S:1157544 HI:881945]
[main] 3336804 iterations. [F:2170888 S:1165913 HI:887955]
[main] 3361766 iterations. [F:2187200 S:1174562 HI:894294]
[main] 3384466 iterations. [F:2201852 S:1182610 HI:899958]
[main] 3408794 iterations. [F:2217764 S:1191026 HI:906062]
[main] 3432261 iterations. [F:2232953 S:1199303 HI:911972]
[main] 3448722 iterations. [F:2243762 S:1204955 HI:916115]
[main] 3465051 iterations. [F:2254364 S:1210683 HI:920250]
[main] 3481183 iterations. [F:2264863 S:1216316 HI:924288]
[main] 3498209 iterations. [F:2276011 S:1222197 HI:928543]
[main] 3515026 iterations. [F:2287118 S:1227904 HI:932743]
[main] 3530663 iterations. [F:2297296 S:1233363 HI:936691]
[main] 3547761 iterations. [F:2308524 S:1239235 HI:941054]
[main] 3564449 iterations. [F:2319411 S:1245037 HI:945285]
[main] 3580927 iterations. [F:2330198 S:1250726 HI:949465]
[main] 3597611 iterations. [F:2341148 S:1256458 HI:953654]
[main] 3625294 iterations. [F:2359094 S:1266195 HI:960553]
[main] 3654353 iterations. [F:2378166 S:1276184 HI:967860]
[main] 3678491 iterations. [F:2393698 S:1284789 HI:973960]
[main] 3703115 iterations. [F:2409625 S:1293485 HI:980087]
[main] 3728556 iterations. [F:2426225 S:1302328 HI:986462]
[main] 3751546 iterations. [F:2441125 S:1310418 HI:992239]
[main] 3775720 iterations. [F:2456863 S:1318852 HI:998271]
[main] 3800576 iterations. [F:2473051 S:1327523 HI:1004581]
[main] 3825876 iterations. [F:2489639 S:1336234 HI:1010902]
[main] 3852161 iterations. [F:2506783 S:1345373 HI:1017446]
[main] 3877588 iterations. [F:2523668 S:1353916 HI:1023885]
[main] 3899729 iterations. [F:2538116 S:1361609 HI:1029392]
[main] 3919444 iterations. [F:2551075 S:1368366 HI:1034345]
[main] 3939978 iterations. [F:2564445 S:1375528 HI:1039552]
[main] 3961394 iterations. [F:2578323 S:1383067 HI:1044777]
[main] 3982510 iterations. [F:2592101 S:1390406 HI:1049954]
[main] 4003722 iterations. [F:2606036 S:1397682 HI:1055295]
[main] 4023712 iterations. [F:2619015 S:1404692 HI:1060297]
[main] 4045651 iterations. [F:2633341 S:1412307 HI:1065847]
[main] 4065622 iterations. [F:2646314 S:1419303 HI:1070832]
[main] 4088977 iterations. [F:2661607 S:1427365 HI:1076748]
[main] 4115127 iterations. [F:2678624 S:1436501 HI:1083328]
[main] 4141824 iterations. [F:2696220 S:1445601 HI:1089971]
[main] 4168836 iterations. [F:2713815 S:1455018 HI:1096762]
[main] 4194764 iterations. [F:2730681 S:1464080 HI:1103283]
[main] 4218607 iterations. [F:2746376 S:1472228 HI:1109176]
[main] 4243769 iterations. [F:2762897 S:1480869 HI:1115492]
[main] 4269003 iterations. [F:2779320 S:1489679 HI:1121712]
[main] 4294383 iterations. [F:2795879 S:1498499 HI:1128090]
[main] 4324433 iterations. [F:2815417 S:1509012 HI:1135664]
[main] 4352080 iterations. [F:2833516 S:1518560 HI:1142463]
[main] 4369646 iterations. [F:2844955 S:1524687 HI:1146897]
[main] 4385452 iterations. [F:2855310 S:1530138 HI:1150845]
[main] 4404711 iterations. [F:2867834 S:1536873 HI:1155669]
[main] 4430785 iterations. [F:2884955 S:1545825 HI:1162238]
[main] 4451815 iterations. [F:2898717 S:1553096 HI:1167523]
[main] 4469855 iterations. [F:2910419 S:1559432 HI:1171996]
[main] 4488245 iterations. [F:2922378 S:1565862 HI:1176594]
[main] 4513303 iterations. [F:2938745 S:1574554 HI:1182862]
[main] 4539263 iterations. [F:2955623 S:1583635 HI:1189324]
[main] 4557589 iterations. [F:2967636 S:1589948 HI:1193925]
[main] 4583772 iterations. [F:2984661 S:1599106 HI:1200457]
[main] 4607556 iterations. [F:3000057 S:1607494 HI:1206373]
[main] 4634316 iterations. [F:3017544 S:1616768 HI:1213121]
[main] 4657472 iterations. [F:3032629 S:1624839 HI:1218973]
[main] 4681591 iterations. [F:3048381 S:1633206 HI:1224986]
[main] 4706541 iterations. [F:3064676 S:1641861 HI:1231232]
[main] 4740128 iterations. [F:3086435 S:1653688 HI:1239632]
[main] 4779763 iterations. [F:3112275 S:1667485 HI:1249548]
[main] 4814173 iterations. [F:3134473 S:1679696 HI:1258265]
[main] 4841481 iterations. [F:3152338 S:1689138 HI:1265074]
[main] 4863625 iterations. [F:3166684 S:1696937 HI:1270647]
[main] 4883378 iterations. [F:3179620 S:1703754 HI:1275545]
[main] 4900618 iterations. [F:3190791 S:1709823 HI:1279912]
[main] 4920850 iterations. [F:3203969 S:1716877 HI:1285032]
[main] 4938696 iterations. [F:3215680 S:1723012 HI:1289531]
[main] 4958600 iterations. [F:3228704 S:1729891 HI:1294515]
[main] 4977687 iterations. [F:3241069 S:1736614 HI:1299343]
[main] 4997202 iterations. [F:3253851 S:1743347 HI:1304257]
[main] 5017185 iterations. [F:3266807 S:1750373 HI:1309267]
[main] 5041757 iterations. [F:3282730 S:1759023 HI:1315346]
[main] 5064292 iterations. [F:3297520 S:1766768 HI:1320932]
[main] 5090488 iterations. [F:3314513 S:1775971 HI:1327513]
[main] 5116588 iterations. [F:3331554 S:1785030 HI:1334117]
[main] 5142529 iterations. [F:3348557 S:1793969 HI:1340675]
[main] 5172294 iterations. [F:3367994 S:1804297 HI:1348170]
[main] 5198113 iterations. [F:3384822 S:1813286 HI:1354695]
[main] 5222628 iterations. [F:3400830 S:1821794 HI:1360770]
[main] 5249382 iterations. [F:3418427 S:1830951 HI:1367534]
[main] 5272768 iterations. [F:3433741 S:1839022 HI:1373346]
[main] 5297767 iterations. [F:3449997 S:1847765 HI:1379642]
[main] 5320217 iterations. [F:3464587 S:1855627 HI:1385189]
[main] 5336592 iterations. [F:3475149 S:1861438 HI:1389302]
[main] 5353322 iterations. [F:3486043 S:1867277 HI:1393488]
[main] 5368643 iterations. [F:3496090 S:1872549 HI:1397328]
[main] 5383431 iterations. [F:3505669 S:1877757 HI:1401078]
[main] 5402040 iterations. [F:3517791 S:1884245 HI:1405696]
[main] 5417152 iterations. [F:3527637 S:1889511 HI:1409426]
[main] 5434927 iterations. [F:3539239 S:1895683 HI:1413875]
[main] 5450196 iterations. [F:3549178 S:1901013 HI:1417686]
[main] 5466019 iterations. [F:3559528 S:1906488 HI:1421662]
[main] 5485600 iterations. [F:3572278 S:1913317 HI:1426525]
[main] 5509140 iterations. [F:3587576 S:1921560 HI:1432387]
[main] 5532893 iterations. [F:3603048 S:1929840 HI:1438375]
[main] 5559109 iterations. [F:3620072 S:1939033 HI:1444964]
[main] 5581227 iterations. [F:3634524 S:1946699 HI:1450448]
[main] 5605393 iterations. [F:3650356 S:1955033 HI:1456508]
[main] 5629841 iterations. [F:3666242 S:1963595 HI:1462663]
[main] 5656581 iterations. [F:3683687 S:1972890 HI:1469405]
[main] 5679703 iterations. [F:3698851 S:1980849 HI:1475243]
[main] 5703318 iterations. [F:3714351 S:1988963 HI:1481240]
[main] 5725943 iterations. [F:3729189 S:1996749 HI:1486930]
[main] 5747194 iterations. [F:3743069 S:2004121 HI:1492274]
[main] 5769479 iterations. [F:3757593 S:2011882 HI:1497875]
[main] 5792734 iterations. [F:3772714 S:2020018 HI:1503685]
[main] 5814144 iterations. [F:3786603 S:2027536 HI:1509067]
[main] 5837514 iterations. [F:3801855 S:2035655 HI:1514956]
[main] 5859602 iterations. [F:3816261 S:2043337 HI:1520476]
[main] 5882315 iterations. [F:3831177 S:2051134 HI:1526251]
[main] 5905734 iterations. [F:3846377 S:2059354 HI:1532112]
[main] 5927102 iterations. [F:3860242 S:2066857 HI:1537428]
[main] 5948282 iterations. [F:3874087 S:2074191 HI:1542751]
[main] 5975090 iterations. [F:3891687 S:2083400 HI:1549446]
[main] 6004624 iterations. [F:3910982 S:2093639 HI:1556845]
[main] 6029279 iterations. [F:3927105 S:2102171 HI:1562977]
[main] 6055393 iterations. [F:3944159 S:2111229 HI:1569483]
[main] 6082531 iterations. [F:3962013 S:2120514 HI:1576230]
[main] 6110094 iterations. [F:3980013 S:2130079 HI:1583165]
[main] 6136915 iterations. [F:3997501 S:2139410 HI:1589902]
[main] 6163142 iterations. [F:4014568 S:2148571 HI:1596507]
[main] 6187373 iterations. [F:4030416 S:2156952 HI:1602620]
[main] 6212738 iterations. [F:4047036 S:2165699 HI:1608981]
[main] 6238299 iterations. [F:4063800 S:2174494 HI:1615413]
[main] 6255380 iterations. [F:4074968 S:2180409 HI:1619715]
[main] 6273840 iterations. [F:4087034 S:2186803 HI:1624287]
[main] 6289629 iterations. [F:4097358 S:2192267 HI:1628285]
[main] 6308169 iterations. [F:4109327 S:2198839 HI:1632892]
[main] 6326532 iterations. [F:4121301 S:2205227 HI:1637540]
[main] 6345269 iterations. [F:4133517 S:2211747 HI:1642198]
[main] 6364086 iterations. [F:4145664 S:2218418 HI:1646866]
[main] 6377393 iterations. [F:4154321 S:2223069 HI:1650157]
[main] 6394298 iterations. [F:4165339 S:2228956 HI:1654416]
[main] 6413465 iterations. [F:4177942 S:2235519 HI:1659290]
[main] 6438455 iterations. [F:4194205 S:2244248 HI:1665567]
[main] 6464163 iterations. [F:4211106 S:2253054 HI:1672054]
[main] 6489281 iterations. [F:4227551 S:2261725 HI:1678322]
[main] 6516586 iterations. [F:4245660 S:2270922 HI:1685188]
[main] 6540760 iterations. [F:4261503 S:2279253 HI:1691197]
[main] 6565972 iterations. [F:4278154 S:2287814 HI:1697575]
[main] 6589919 iterations. [F:4293764 S:2296150 HI:1703548]
[main] 6613903 iterations. [F:4309495 S:2304403 HI:1709485]
[main] 6643638 iterations. [F:4328948 S:2314686 HI:1716933]
[main] 6669411 iterations. [F:4345820 S:2323588 HI:1723455]
[main] 6688708 iterations. [F:4358542 S:2330161 HI:1728233]
[main] 6707312 iterations. [F:4370753 S:2336556 HI:1732960]
[main] 6722539 iterations. [F:4380732 S:2341803 HI:1736820]
[main] 6740435 iterations. [F:4392551 S:2347880 HI:1741289]
[main] 6758671 iterations. [F:4404581 S:2354086 HI:1745881]
[main] 6776418 iterations. [F:4416337 S:2360076 HI:1750367]
[main] 6795503 iterations. [F:4428939 S:2366562 HI:1755176]
[main] 6817004 iterations. [F:4443196 S:2373804 HI:1760574]
[main] 6839909 iterations. [F:4458358 S:2381548 HI:1766280]
[main] 6859428 iterations. [F:4471289 S:2388135 HI:1771153]
[main] 6883525 iterations. [F:4487308 S:2396212 HI:1777268]
[main] 6908178 iterations. [F:4503564 S:2404611 HI:1783466]
[main] 6930444 iterations. [F:4518250 S:2412192 HI:1788961]
[main] 6954424 iterations. [F:4534115 S:2420304 HI:1794914]

--snVoKl3TBKn/uiev--
