Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9558A015
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiHDRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbiHDRzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:55:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A66BCA9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659635743; x=1691171743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gZkOyoiV0ZbMA805mv3p5PYtu7vOdgaeY4SEvlIX/Io=;
  b=BACgLcSYZ2VHKSHjvhwmsRu+CsX4hsLZtf6J/cFBCsQOTC6BA/PSBpA8
   BikL85tJ7UCdmq75Ibg+0VkFu4+e9sfBawLF6VQmyMX6LkCTVUQ5ey0mN
   XGnNybFbgvHSJOJqox7Oxl+sTdglKvko7Y6Y01E65UgHdVvjvtOOx8NxD
   AA9zyYEbUpcHaq1BzJFYUoSXuCqNEq5JiGaGzIBQzEbcf962jgLplE9TX
   TPYRmSphOC+KVXSQODpv25YOdn1Sd/6Mft/Nja58GHn420VUv5aEdqUP1
   ku0/oOFsiH5s98Z7kyhNNkJcgrj/7+FUxOAPHJq7RXeqvI2P++pY3RyN2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="351717216"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="351717216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 10:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="662639058"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2022 10:55:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJf4D-000IhP-1F;
        Thu, 04 Aug 2022 17:55:29 +0000
Date:   Fri, 5 Aug 2022 01:54:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian =?iso-8859-1?Q?W=FCrl?= <sebastian.wuerl@ororatech.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/net/can/spi/mcp251x.c:1073:7: warning: variable 'intf1' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202208050128.gFQ9dERP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220804-145223/Sebastian-W-rl/drivers-net-can-spi-mcp251x-c-Fix-race-condition-on-receive-interrupt/20220803-233455
head:   ba4ce3d25ad57d7601a8bc5f41293923b46eb134
commit: ba4ce3d25ad57d7601a8bc5f41293923b46eb134 can: mcp251x: Fix race condition on receive interrupt
date:   11 hours ago
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220805/202208050128.gFQ9dERP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ba4ce3d25ad57d7601a8bc5f41293923b46eb134
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220804-145223/Sebastian-W-rl/drivers-net-can-spi-mcp251x-c-Fix-race-condition-on-receive-interrupt/20220803-233455
        git checkout ba4ce3d25ad57d7601a8bc5f41293923b46eb134
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/can/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/can/spi/mcp251x.c:1073:7: warning: variable 'intf1' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (intf0 & CANINTF_RX0IF) {
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/spi/mcp251x.c:1092:7: note: uninitialized use occurs here
                   if (intf1 & CANINTF_RX1IF) {
                       ^~~~~
   drivers/net/can/spi/mcp251x.c:1073:3: note: remove the 'if' if its condition is always true
                   if (intf0 & CANINTF_RX0IF) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/spi/mcp251x.c:1066:24: note: initialize the variable 'intf1' to silence this warning
                   u8 intf, intf0, intf1, eflag, eflag0, eflag1;
                                        ^
                                         = '\0'
>> drivers/net/can/spi/mcp251x.c:1082:8: warning: variable 'eflag1' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                           if (intf0 & CANINTF_RX1IF) {
                               ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/spi/mcp251x.c:1101:20: note: uninitialized use occurs here
                   eflag = eflag0 | eflag1;
                                    ^~~~~~
   drivers/net/can/spi/mcp251x.c:1082:4: note: remove the 'if' if its condition is always false
                           if (intf0 & CANINTF_RX1IF) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/can/spi/mcp251x.c:1073:7: warning: variable 'eflag1' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (intf0 & CANINTF_RX0IF) {
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/spi/mcp251x.c:1101:20: note: uninitialized use occurs here
                   eflag = eflag0 | eflag1;
                                    ^~~~~~
   drivers/net/can/spi/mcp251x.c:1073:3: note: remove the 'if' if its condition is always true
                   if (intf0 & CANINTF_RX0IF) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/spi/mcp251x.c:1066:47: note: initialize the variable 'eflag1' to silence this warning
                   u8 intf, intf0, intf1, eflag, eflag0, eflag1;
                                                               ^
                                                                = '\0'
   3 warnings generated.


vim +1073 drivers/net/can/spi/mcp251x.c

  1056	
  1057	static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
  1058	{
  1059		struct mcp251x_priv *priv = dev_id;
  1060		struct spi_device *spi = priv->spi;
  1061		struct net_device *net = priv->net;
  1062	
  1063		mutex_lock(&priv->mcp_lock);
  1064		while (!priv->force_quit) {
  1065			enum can_state new_state;
  1066			u8 intf, intf0, intf1, eflag, eflag0, eflag1;
  1067			u8 clear_intf = 0;
  1068			int can_id = 0, data1 = 0;
  1069	
  1070			mcp251x_read_2regs(spi, CANINTF, &intf0, &eflag0);
  1071	
  1072			/* receive buffer 0 */
> 1073			if (intf0 & CANINTF_RX0IF) {
  1074				mcp251x_hw_rx(spi, 0);
  1075				/* Free one buffer ASAP
  1076				 * (The MCP2515/25625 does this automatically.)
  1077				 */
  1078				if (mcp251x_is_2510(spi))
  1079					mcp251x_write_bits(spi, CANINTF,
  1080							   CANINTF_RX0IF, 0x00);
  1081	
> 1082				if (intf0 & CANINTF_RX1IF) {
  1083					/* buffer 1 is already known to be full, no need to re-read */
  1084					intf1 = intf0;
  1085				} else {
  1086					/* intf needs to be read again to avoid a race condition */
  1087					mcp251x_read_2regs(spi, CANINTF, &intf1, &eflag1);
  1088				}
  1089			}
  1090	
  1091			/* receive buffer 1 */
  1092			if (intf1 & CANINTF_RX1IF) {
  1093				mcp251x_hw_rx(spi, 1);
  1094				/* The MCP2515/25625 does this automatically. */
  1095				if (mcp251x_is_2510(spi))
  1096					clear_intf |= CANINTF_RX1IF;
  1097			}
  1098	
  1099			/* combine flags from both operations for error handling */
  1100			intf = intf0 | intf1;
  1101			eflag = eflag0 | eflag1;
  1102	
  1103			/* mask out flags we don't care about */
  1104			intf &= CANINTF_RX | CANINTF_TX | CANINTF_ERR;
  1105	
  1106			/* any error or tx interrupt we need to clear? */
  1107			if (intf & (CANINTF_ERR | CANINTF_TX))
  1108				clear_intf |= intf & (CANINTF_ERR | CANINTF_TX);
  1109			if (clear_intf)
  1110				mcp251x_write_bits(spi, CANINTF, clear_intf, 0x00);
  1111	
  1112			if (eflag & (EFLG_RX0OVR | EFLG_RX1OVR))
  1113				mcp251x_write_bits(spi, EFLG, eflag, 0x00);
  1114	
  1115			/* Update can state */
  1116			if (eflag & EFLG_TXBO) {
  1117				new_state = CAN_STATE_BUS_OFF;
  1118				can_id |= CAN_ERR_BUSOFF;
  1119			} else if (eflag & EFLG_TXEP) {
  1120				new_state = CAN_STATE_ERROR_PASSIVE;
  1121				can_id |= CAN_ERR_CRTL;
  1122				data1 |= CAN_ERR_CRTL_TX_PASSIVE;
  1123			} else if (eflag & EFLG_RXEP) {
  1124				new_state = CAN_STATE_ERROR_PASSIVE;
  1125				can_id |= CAN_ERR_CRTL;
  1126				data1 |= CAN_ERR_CRTL_RX_PASSIVE;
  1127			} else if (eflag & EFLG_TXWAR) {
  1128				new_state = CAN_STATE_ERROR_WARNING;
  1129				can_id |= CAN_ERR_CRTL;
  1130				data1 |= CAN_ERR_CRTL_TX_WARNING;
  1131			} else if (eflag & EFLG_RXWAR) {
  1132				new_state = CAN_STATE_ERROR_WARNING;
  1133				can_id |= CAN_ERR_CRTL;
  1134				data1 |= CAN_ERR_CRTL_RX_WARNING;
  1135			} else {
  1136				new_state = CAN_STATE_ERROR_ACTIVE;
  1137			}
  1138	
  1139			/* Update can state statistics */
  1140			switch (priv->can.state) {
  1141			case CAN_STATE_ERROR_ACTIVE:
  1142				if (new_state >= CAN_STATE_ERROR_WARNING &&
  1143				    new_state <= CAN_STATE_BUS_OFF)
  1144					priv->can.can_stats.error_warning++;
  1145				fallthrough;
  1146			case CAN_STATE_ERROR_WARNING:
  1147				if (new_state >= CAN_STATE_ERROR_PASSIVE &&
  1148				    new_state <= CAN_STATE_BUS_OFF)
  1149					priv->can.can_stats.error_passive++;
  1150				break;
  1151			default:
  1152				break;
  1153			}
  1154			priv->can.state = new_state;
  1155	
  1156			if (intf & CANINTF_ERRIF) {
  1157				/* Handle overflow counters */
  1158				if (eflag & (EFLG_RX0OVR | EFLG_RX1OVR)) {
  1159					if (eflag & EFLG_RX0OVR) {
  1160						net->stats.rx_over_errors++;
  1161						net->stats.rx_errors++;
  1162					}
  1163					if (eflag & EFLG_RX1OVR) {
  1164						net->stats.rx_over_errors++;
  1165						net->stats.rx_errors++;
  1166					}
  1167					can_id |= CAN_ERR_CRTL;
  1168					data1 |= CAN_ERR_CRTL_RX_OVERFLOW;
  1169				}
  1170				mcp251x_error_skb(net, can_id, data1);
  1171			}
  1172	
  1173			if (priv->can.state == CAN_STATE_BUS_OFF) {
  1174				if (priv->can.restart_ms == 0) {
  1175					priv->force_quit = 1;
  1176					priv->can.can_stats.bus_off++;
  1177					can_bus_off(net);
  1178					mcp251x_hw_sleep(spi);
  1179					break;
  1180				}
  1181			}
  1182	
  1183			if (intf == 0)
  1184				break;
  1185	
  1186			if (intf & CANINTF_TX) {
  1187				if (priv->tx_busy) {
  1188					net->stats.tx_packets++;
  1189					net->stats.tx_bytes += can_get_echo_skb(net, 0,
  1190										NULL);
  1191					priv->tx_busy = false;
  1192				}
  1193				netif_wake_queue(net);
  1194			}
  1195		}
  1196		mutex_unlock(&priv->mcp_lock);
  1197		return IRQ_HANDLED;
  1198	}
  1199	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
