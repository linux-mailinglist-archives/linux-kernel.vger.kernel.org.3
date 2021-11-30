Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0443B463F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbhK3Uzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:55:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:36867 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242493AbhK3Uzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:55:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217009109"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="217009109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="499934537"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2021 12:52:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msA70-000DlE-Mi; Tue, 30 Nov 2021 20:52:26 +0000
Date:   Wed, 1 Dec 2021 04:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: net/mptcp/options.c:1480:2: error: expected expression before '}'
 token
Message-ID: <202112010428.BQCXxgg0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211201-005553/Geliang-Tang/send-MP_FAIL-with-MP_RST-and-others/20211130-112305
head:   adc0a23071eeb92c359bcb329e2108055f998fdf
commit: adc9aee6789d25e2e5e9a798f234e74414a14f11 Squash to "mptcp: implement fastclose xmit path"
date:   4 hours ago
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211201/202112010428.BQCXxgg0-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/adc9aee6789d25e2e5e9a798f234e74414a14f11
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211201-005553/Geliang-Tang/send-MP_FAIL-with-MP_RST-and-others/20211130-112305
        git checkout adc9aee6789d25e2e5e9a798f234e74414a14f11
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mptcp/options.c: In function 'mptcp_write_options':
>> net/mptcp/options.c:1480:2: error: expected expression before '}' token
    1480 |  } else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
         |  ^
   net/mptcp/options.c:1480:2: error: 'return' with a value, in function returning void [-Werror=return-type]
   net/mptcp/options.c:1263:6: note: declared here
    1263 | void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1480 net/mptcp/options.c

  1426	
  1427			if (!opts->addr.port) {
  1428				if (opts->ahmac) {
  1429					put_unaligned_be64(opts->ahmac, ptr);
  1430					ptr += 2;
  1431				}
  1432			} else {
  1433				u16 port = ntohs(opts->addr.port);
  1434	
  1435				if (opts->ahmac) {
  1436					u8 *bptr = (u8 *)ptr;
  1437	
  1438					put_unaligned_be16(port, bptr);
  1439					bptr += 2;
  1440					put_unaligned_be64(opts->ahmac, bptr);
  1441					bptr += 8;
  1442					put_unaligned_be16(TCPOPT_NOP << 8 |
  1443							   TCPOPT_NOP, bptr);
  1444	
  1445					ptr += 3;
  1446				} else {
  1447					put_unaligned_be32(port << 16 |
  1448							   TCPOPT_NOP << 8 |
  1449							   TCPOPT_NOP, ptr);
  1450					ptr += 1;
  1451				}
  1452			}
  1453		} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
  1454			/* FASTCLOSE is mutually exclusive with others except RST */
  1455			*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
  1456					      TCPOLEN_MPTCP_FASTCLOSE,
  1457					      0, 0);
  1458			put_unaligned_be64(opts->rcvr_key, ptr);
  1459	
  1460			if (OPTION_MPTCP_RST & opts->suboptions)
  1461				goto mp_rst;
  1462			return;
  1463		} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
  1464			/* MP_FAIL is mutually exclusive with others except RST */
  1465			const struct sock *ssk = (const struct sock *)tp;
  1466			struct mptcp_subflow_context *subflow;
  1467	
  1468			subflow = mptcp_subflow_ctx(ssk);
  1469			subflow->send_mp_fail = 0;
  1470	
  1471			*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
  1472					      TCPOLEN_MPTCP_FAIL,
  1473					      0, 0);
  1474			put_unaligned_be64(opts->fail_seq, ptr);
  1475			ptr += 2;
  1476	
  1477			if (OPTION_MPTCP_RST & opts->suboptions)
  1478				goto mp_rst;
  1479			return
> 1480		} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
  1481	mp_rst:
  1482			*ptr++ = mptcp_option(MPTCPOPT_RST,
  1483					      TCPOLEN_MPTCP_RST,
  1484					      opts->reset_transient,
  1485					      opts->reset_reason);
  1486			return;
  1487		}
  1488	
  1489		if (OPTION_MPTCP_PRIO & opts->suboptions) {
  1490			const struct sock *ssk = (const struct sock *)tp;
  1491			struct mptcp_subflow_context *subflow;
  1492	
  1493			subflow = mptcp_subflow_ctx(ssk);
  1494			subflow->send_mp_prio = 0;
  1495	
  1496			*ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
  1497					      TCPOLEN_MPTCP_PRIO,
  1498					      opts->backup, TCPOPT_NOP);
  1499		}
  1500	
  1501	mp_capable_done:
  1502		if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
  1503			u8 i = 1;
  1504	
  1505			*ptr++ = mptcp_option(MPTCPOPT_RM_ADDR,
  1506					      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
  1507					      0, opts->rm_list.ids[0]);
  1508	
  1509			while (i < opts->rm_list.nr) {
  1510				u8 id1, id2, id3, id4;
  1511	
  1512				id1 = opts->rm_list.ids[i];
  1513				id2 = i + 1 < opts->rm_list.nr ? opts->rm_list.ids[i + 1] : TCPOPT_NOP;
  1514				id3 = i + 2 < opts->rm_list.nr ? opts->rm_list.ids[i + 2] : TCPOPT_NOP;
  1515				id4 = i + 3 < opts->rm_list.nr ? opts->rm_list.ids[i + 3] : TCPOPT_NOP;
  1516				put_unaligned_be32(id1 << 24 | id2 << 16 | id3 << 8 | id4, ptr);
  1517				ptr += 1;
  1518				i += 4;
  1519			}
  1520		}
  1521	
  1522		if (tp)
  1523			mptcp_set_rwin(tp);
  1524	}
  1525	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
