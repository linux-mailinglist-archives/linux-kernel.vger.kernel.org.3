Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B14D95CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbiCOH6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345721AbiCOH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:58:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1DF4BBAF;
        Tue, 15 Mar 2022 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647331040; x=1678867040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1S8LpfKX5S7zmZYIuR+5PWkpHLWiUnjD5YgcjFZ7k0=;
  b=ZOzkcB85Wf/op7X45jF6X5t6B7aWJbljlM7LSZg2dHBP1YFrH7XHtRD7
   /HF3EUeA/v8sDrK91GAC+tc8cfUoOcGdahkUdbgxiMToNCUHpFAyi6RSg
   ByTPQMVHqgR+jYliHfOsz6awR/81sa2kyv9e6x9DaVpED6gOPCIcklb3N
   vMinBKduC5LfW8UJT0E4c+lSmz46reX1PNXLNjEDfUi0atIz9NdpBx2PX
   4A+R0MsKmGv8TlpTpd7g2k6byakfWhqtm+0W4mA+YA/W/4iVvGbCDJIux
   9cOkS2JRS2sB0AXnLD428XtCiIw8V6HDBc8YBol1KSL8zAh7SQyZl96Wd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255967351"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255967351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 00:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="714064174"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 00:57:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU23L-000Ahv-O9; Tue, 15 Mar 2022 07:57:11 +0000
Date:   Tue, 15 Mar 2022 15:56:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] s390/tape: Use bitwise instead of arithmetic operator
 for flags
Message-ID: <202203151554.mlaV8elU-lkp@intel.com>
References: <1647311083-25388-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647311083-25388-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on v5.17-rc8 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Haowen-Bai/s390-tape-Use-bitwise-instead-of-arithmetic-operator-for-flags/20220315-102644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-defconfig (https://download.01.org/0day-ci/archive/20220315/202203151554.mlaV8elU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c549742b07b69efbf79208adc82f8a5650cc7311
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Haowen-Bai/s390-tape-Use-bitwise-instead-of-arithmetic-operator-for-flags/20220315-102644
        git checkout c549742b07b69efbf79208adc82f8a5650cc7311
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/s390/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/s390/char/tape_34xx.c: In function 'tape_34xx_unit_check':
>> drivers/s390/char/tape_34xx.c:357:26: warning: suggest parentheses around comparison in operand of '|' [-Wparentheses]
     357 |                 sense[0] == SENSE_EQUIPMENT_CHECK | SENSE_DEFERRED_UNIT_CHECK
   drivers/s390/char/tape_34xx.c:360:26: warning: suggest parentheses around comparison in operand of '|' [-Wparentheses]
     360 |                 sense[1] == SENSE_BEGINNING_OF_TAPE | SENSE_WRITE_MODE


vim +357 drivers/s390/char/tape_34xx.c

   310	
   311	/*
   312	 * This function analyses the tape's sense-data in case of a unit-check.
   313	 * If possible, it tries to recover from the error. Else the user is
   314	 * informed about the problem.
   315	 */
   316	static int
   317	tape_34xx_unit_check(struct tape_device *device, struct tape_request *request,
   318			     struct irb *irb)
   319	{
   320		int inhibit_cu_recovery;
   321		__u8* sense;
   322	
   323		inhibit_cu_recovery = (*device->modeset_byte & 0x80) ? 1 : 0;
   324		sense = irb->ecw;
   325	
   326		if (
   327			sense[0] & SENSE_COMMAND_REJECT &&
   328			sense[1] & SENSE_WRITE_PROTECT
   329		) {
   330			if (
   331				request->op == TO_DSE ||
   332				request->op == TO_WRI ||
   333				request->op == TO_WTM
   334			) {
   335				/* medium is write protected */
   336				return tape_34xx_erp_failed(request, -EACCES);
   337			} else {
   338				return tape_34xx_erp_bug(device, request, irb, -3);
   339			}
   340		}
   341	
   342		/*
   343		 * Special cases for various tape-states when reaching
   344		 * end of recorded area
   345		 *
   346		 * FIXME: Maybe a special case of the special case:
   347		 *        sense[0] == SENSE_EQUIPMENT_CHECK &&
   348		 *        sense[1] == SENSE_DRIVE_ONLINE    &&
   349		 *        sense[3] == 0x47 (Volume Fenced)
   350		 *
   351		 *        This was caused by continued FSF or FSR after an
   352		 *        'End Of Data'.
   353		 */
   354		if ((
   355			sense[0] == SENSE_DATA_CHECK      ||
   356			sense[0] == SENSE_EQUIPMENT_CHECK ||
 > 357			sense[0] == SENSE_EQUIPMENT_CHECK | SENSE_DEFERRED_UNIT_CHECK
   358		) && (
   359			sense[1] == SENSE_DRIVE_ONLINE ||
   360			sense[1] == SENSE_BEGINNING_OF_TAPE | SENSE_WRITE_MODE
   361		)) {
   362			switch (request->op) {
   363			/*
   364			 * sense[0] == SENSE_DATA_CHECK   &&
   365			 * sense[1] == SENSE_DRIVE_ONLINE
   366			 * sense[3] == 0x36 (End Of Data)
   367			 *
   368			 * Further seeks might return a 'Volume Fenced'.
   369			 */
   370			case TO_FSF:
   371			case TO_FSB:
   372				/* Trying to seek beyond end of recorded area */
   373				return tape_34xx_erp_failed(request, -ENOSPC);
   374			case TO_BSB:
   375				return tape_34xx_erp_retry(request);
   376	
   377			/*
   378			 * sense[0] == SENSE_DATA_CHECK   &&
   379			 * sense[1] == SENSE_DRIVE_ONLINE &&
   380			 * sense[3] == 0x36 (End Of Data)
   381			 */
   382			case TO_LBL:
   383				/* Block could not be located. */
   384				tape_34xx_delete_sbid_from(device, 0);
   385				return tape_34xx_erp_failed(request, -EIO);
   386	
   387			case TO_RFO:
   388				/* Read beyond end of recorded area -> 0 bytes read */
   389				return tape_34xx_erp_failed(request, 0);
   390	
   391			/*
   392			 * sense[0] == SENSE_EQUIPMENT_CHECK &&
   393			 * sense[1] == SENSE_DRIVE_ONLINE    &&
   394			 * sense[3] == 0x38 (Physical End Of Volume)
   395			 */
   396			case TO_WRI:
   397				/* Writing at physical end of volume */
   398				return tape_34xx_erp_failed(request, -ENOSPC);
   399			default:
   400				return tape_34xx_erp_failed(request, 0);
   401			}
   402		}
   403	
   404		/* Sensing special bits */
   405		if (sense[0] & SENSE_BUS_OUT_CHECK)
   406			return tape_34xx_erp_retry(request);
   407	
   408		if (sense[0] & SENSE_DATA_CHECK) {
   409			/*
   410			 * hardware failure, damaged tape or improper
   411			 * operating conditions
   412			 */
   413			switch (sense[3]) {
   414			case 0x23:
   415				/* a read data check occurred */
   416				if ((sense[2] & SENSE_TAPE_SYNC_MODE) ||
   417				    inhibit_cu_recovery)
   418					// data check is not permanent, may be
   419					// recovered. We always use async-mode with
   420					// cu-recovery, so this should *never* happen.
   421					return tape_34xx_erp_bug(device, request,
   422								 irb, -4);
   423	
   424				/* data check is permanent, CU recovery has failed */
   425				dev_warn (&device->cdev->dev, "A read error occurred "
   426					"that cannot be recovered\n");
   427				return tape_34xx_erp_failed(request, -EIO);
   428			case 0x25:
   429				// a write data check occurred
   430				if ((sense[2] & SENSE_TAPE_SYNC_MODE) ||
   431				    inhibit_cu_recovery)
   432					// data check is not permanent, may be
   433					// recovered. We always use async-mode with
   434					// cu-recovery, so this should *never* happen.
   435					return tape_34xx_erp_bug(device, request,
   436								 irb, -5);
   437	
   438				// data check is permanent, cu-recovery has failed
   439				dev_warn (&device->cdev->dev, "A write error on the "
   440					"tape cannot be recovered\n");
   441				return tape_34xx_erp_failed(request, -EIO);
   442			case 0x26:
   443				/* Data Check (read opposite) occurred. */
   444				return tape_34xx_erp_read_opposite(device, request);
   445			case 0x28:
   446				/* ID-Mark at tape start couldn't be written */
   447				dev_warn (&device->cdev->dev, "Writing the ID-mark "
   448					"failed\n");
   449				return tape_34xx_erp_failed(request, -EIO);
   450			case 0x31:
   451				/* Tape void. Tried to read beyond end of device. */
   452				dev_warn (&device->cdev->dev, "Reading the tape beyond"
   453					" the end of the recorded area failed\n");
   454				return tape_34xx_erp_failed(request, -ENOSPC);
   455			case 0x41:
   456				/* Record sequence error. */
   457				dev_warn (&device->cdev->dev, "The tape contains an "
   458					"incorrect block ID sequence\n");
   459				return tape_34xx_erp_failed(request, -EIO);
   460			default:
   461				/* all data checks for 3480 should result in one of
   462				 * the above erpa-codes. For 3490, other data-check
   463				 * conditions do exist. */
   464				if (device->cdev->id.driver_info == tape_3480)
   465					return tape_34xx_erp_bug(device, request,
   466								 irb, -6);
   467			}
   468		}
   469	
   470		if (sense[0] & SENSE_OVERRUN)
   471			return tape_34xx_erp_overrun(device, request, irb);
   472	
   473		if (sense[1] & SENSE_RECORD_SEQUENCE_ERR)
   474			return tape_34xx_erp_sequence(device, request, irb);
   475	
   476		/* Sensing erpa codes */
   477		switch (sense[3]) {
   478		case 0x00:
   479			/* Unit check with erpa code 0. Report and ignore. */
   480			return TAPE_IO_SUCCESS;
   481		case 0x21:
   482			/*
   483			 * Data streaming not operational. CU will switch to
   484			 * interlock mode. Reissue the command.
   485			 */
   486			return tape_34xx_erp_retry(request);
   487		case 0x22:
   488			/*
   489			 * Path equipment check. Might be drive adapter error, buffer
   490			 * error on the lower interface, internal path not usable,
   491			 * or error during cartridge load.
   492			 */
   493			dev_warn (&device->cdev->dev, "A path equipment check occurred"
   494				" for the tape device\n");
   495			return tape_34xx_erp_failed(request, -EIO);
   496		case 0x24:
   497			/*
   498			 * Load display check. Load display was command was issued,
   499			 * but the drive is displaying a drive check message. Can
   500			 * be threated as "device end".
   501			 */
   502			return tape_34xx_erp_succeeded(request);
   503		case 0x27:
   504			/*
   505			 * Command reject. May indicate illegal channel program or
   506			 * buffer over/underrun. Since all channel programs are
   507			 * issued by this driver and ought be correct, we assume a
   508			 * over/underrun situation and retry the channel program.
   509			 */
   510			return tape_34xx_erp_retry(request);
   511		case 0x29:
   512			/*
   513			 * Function incompatible. Either the tape is idrc compressed
   514			 * but the hardware isn't capable to do idrc, or a perform
   515			 * subsystem func is issued and the CU is not on-line.
   516			 */
   517			return tape_34xx_erp_failed(request, -EIO);
   518		case 0x2a:
   519			/*
   520			 * Unsolicited environmental data. An internal counter
   521			 * overflows, we can ignore this and reissue the cmd.
   522			 */
   523			return tape_34xx_erp_retry(request);
   524		case 0x2b:
   525			/*
   526			 * Environmental data present. Indicates either unload
   527			 * completed ok or read buffered log command completed ok.
   528			 */
   529			if (request->op == TO_RUN) {
   530				/* Rewind unload completed ok. */
   531				tape_med_state_set(device, MS_UNLOADED);
   532				return tape_34xx_erp_succeeded(request);
   533			}
   534			/* tape_34xx doesn't use read buffered log commands. */
   535			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   536		case 0x2c:
   537			/*
   538			 * Permanent equipment check. CU has tried recovery, but
   539			 * did not succeed.
   540			 */
   541			return tape_34xx_erp_failed(request, -EIO);
   542		case 0x2d:
   543			/* Data security erase failure. */
   544			if (request->op == TO_DSE)
   545				return tape_34xx_erp_failed(request, -EIO);
   546			/* Data security erase failure, but no such command issued. */
   547			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   548		case 0x2e:
   549			/*
   550			 * Not capable. This indicates either that the drive fails
   551			 * reading the format id mark or that that format specified
   552			 * is not supported by the drive.
   553			 */
   554			dev_warn (&device->cdev->dev, "The tape unit cannot process "
   555				"the tape format\n");
   556			return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
   557		case 0x30:
   558			/* The medium is write protected. */
   559			dev_warn (&device->cdev->dev, "The tape medium is write-"
   560				"protected\n");
   561			return tape_34xx_erp_failed(request, -EACCES);
   562		case 0x32:
   563			// Tension loss. We cannot recover this, it's an I/O error.
   564			dev_warn (&device->cdev->dev, "The tape does not have the "
   565				"required tape tension\n");
   566			return tape_34xx_erp_failed(request, -EIO);
   567		case 0x33:
   568			/*
   569			 * Load Failure. The cartridge was not inserted correctly or
   570			 * the tape is not threaded correctly.
   571			 */
   572			dev_warn (&device->cdev->dev, "The tape unit failed to load"
   573				" the cartridge\n");
   574			tape_34xx_delete_sbid_from(device, 0);
   575			return tape_34xx_erp_failed(request, -EIO);
   576		case 0x34:
   577			/*
   578			 * Unload failure. The drive cannot maintain tape tension
   579			 * and control tape movement during an unload operation.
   580			 */
   581			dev_warn (&device->cdev->dev, "Automatic unloading of the tape"
   582				" cartridge failed\n");
   583			if (request->op == TO_RUN)
   584				return tape_34xx_erp_failed(request, -EIO);
   585			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   586		case 0x35:
   587			/*
   588			 * Drive equipment check. One of the following:
   589			 * - cu cannot recover from a drive detected error
   590			 * - a check code message is shown on drive display
   591			 * - the cartridge loader does not respond correctly
   592			 * - a failure occurs during an index, load, or unload cycle
   593			 */
   594			dev_warn (&device->cdev->dev, "An equipment check has occurred"
   595				" on the tape unit\n");
   596			return tape_34xx_erp_failed(request, -EIO);
   597		case 0x36:
   598			if (device->cdev->id.driver_info == tape_3490)
   599				/* End of data. */
   600				return tape_34xx_erp_failed(request, -EIO);
   601			/* This erpa is reserved for 3480 */
   602			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   603		case 0x37:
   604			/*
   605			 * Tape length error. The tape is shorter than reported in
   606			 * the beginning-of-tape data.
   607			 */
   608			dev_warn (&device->cdev->dev, "The tape information states an"
   609				" incorrect length\n");
   610			return tape_34xx_erp_failed(request, -EIO);
   611		case 0x38:
   612			/*
   613			 * Physical end of tape. A read/write operation reached
   614			 * the physical end of tape.
   615			 */
   616			if (request->op==TO_WRI ||
   617			    request->op==TO_DSE ||
   618			    request->op==TO_WTM)
   619				return tape_34xx_erp_failed(request, -ENOSPC);
   620			return tape_34xx_erp_failed(request, -EIO);
   621		case 0x39:
   622			/* Backward at Beginning of tape. */
   623			return tape_34xx_erp_failed(request, -EIO);
   624		case 0x3a:
   625			/* Drive switched to not ready. */
   626			dev_warn (&device->cdev->dev, "The tape unit is not ready\n");
   627			return tape_34xx_erp_failed(request, -EIO);
   628		case 0x3b:
   629			/* Manual rewind or unload. This causes an I/O error. */
   630			dev_warn (&device->cdev->dev, "The tape medium has been "
   631				"rewound or unloaded manually\n");
   632			tape_34xx_delete_sbid_from(device, 0);
   633			return tape_34xx_erp_failed(request, -EIO);
   634		case 0x42:
   635			/*
   636			 * Degraded mode. A condition that can cause degraded
   637			 * performance is detected.
   638			 */
   639			dev_warn (&device->cdev->dev, "The tape subsystem is running "
   640				"in degraded mode\n");
   641			return tape_34xx_erp_retry(request);
   642		case 0x43:
   643			/* Drive not ready. */
   644			tape_34xx_delete_sbid_from(device, 0);
   645			tape_med_state_set(device, MS_UNLOADED);
   646			/* Some commands commands are successful even in this case */
   647			if (sense[1] & SENSE_DRIVE_ONLINE) {
   648				switch(request->op) {
   649					case TO_ASSIGN:
   650					case TO_UNASSIGN:
   651					case TO_DIS:
   652					case TO_NOP:
   653						return tape_34xx_done(request);
   654						break;
   655					default:
   656						break;
   657				}
   658			}
   659			return tape_34xx_erp_failed(request, -ENOMEDIUM);
   660		case 0x44:
   661			/* Locate Block unsuccessful. */
   662			if (request->op != TO_BLOCK && request->op != TO_LBL)
   663				/* No locate block was issued. */
   664				return tape_34xx_erp_bug(device, request,
   665							 irb, sense[3]);
   666			return tape_34xx_erp_failed(request, -EIO);
   667		case 0x45:
   668			/* The drive is assigned to a different channel path. */
   669			dev_warn (&device->cdev->dev, "The tape unit is already "
   670				"assigned\n");
   671			return tape_34xx_erp_failed(request, -EIO);
   672		case 0x46:
   673			/*
   674			 * Drive not on-line. Drive may be switched offline,
   675			 * the power supply may be switched off or
   676			 * the drive address may not be set correctly.
   677			 */
   678			dev_warn (&device->cdev->dev, "The tape unit is not online\n");
   679			return tape_34xx_erp_failed(request, -EIO);
   680		case 0x47:
   681			/* Volume fenced. CU reports volume integrity is lost. */
   682			dev_warn (&device->cdev->dev, "The control unit has fenced "
   683				"access to the tape volume\n");
   684			tape_34xx_delete_sbid_from(device, 0);
   685			return tape_34xx_erp_failed(request, -EIO);
   686		case 0x48:
   687			/* Log sense data and retry request. */
   688			return tape_34xx_erp_retry(request);
   689		case 0x49:
   690			/* Bus out check. A parity check error on the bus was found. */
   691			dev_warn (&device->cdev->dev, "A parity error occurred on the "
   692				"tape bus\n");
   693			return tape_34xx_erp_failed(request, -EIO);
   694		case 0x4a:
   695			/* Control unit erp failed. */
   696			dev_warn (&device->cdev->dev, "I/O error recovery failed on "
   697				"the tape control unit\n");
   698			return tape_34xx_erp_failed(request, -EIO);
   699		case 0x4b:
   700			/*
   701			 * CU and drive incompatible. The drive requests micro-program
   702			 * patches, which are not available on the CU.
   703			 */
   704			dev_warn (&device->cdev->dev, "The tape unit requires a "
   705				"firmware update\n");
   706			return tape_34xx_erp_failed(request, -EIO);
   707		case 0x4c:
   708			/*
   709			 * Recovered Check-One failure. Cu develops a hardware error,
   710			 * but is able to recover.
   711			 */
   712			return tape_34xx_erp_retry(request);
   713		case 0x4d:
   714			if (device->cdev->id.driver_info == tape_3490)
   715				/*
   716				 * Resetting event received. Since the driver does
   717				 * not support resetting event recovery (which has to
   718				 * be handled by the I/O Layer), retry our command.
   719				 */
   720				return tape_34xx_erp_retry(request);
   721			/* This erpa is reserved for 3480. */
   722			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   723		case 0x4e:
   724			if (device->cdev->id.driver_info == tape_3490) {
   725				/*
   726				 * Maximum block size exceeded. This indicates, that
   727				 * the block to be written is larger than allowed for
   728				 * buffered mode.
   729				 */
   730				dev_warn (&device->cdev->dev, "The maximum block size"
   731					" for buffered mode is exceeded\n");
   732				return tape_34xx_erp_failed(request, -ENOBUFS);
   733			}
   734			/* This erpa is reserved for 3480. */
   735			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   736		case 0x50:
   737			/*
   738			 * Read buffered log (Overflow). CU is running in extended
   739			 * buffered log mode, and a counter overflows. This should
   740			 * never happen, since we're never running in extended
   741			 * buffered log mode.
   742			 */
   743			return tape_34xx_erp_retry(request);
   744		case 0x51:
   745			/*
   746			 * Read buffered log (EOV). EOF processing occurs while the
   747			 * CU is in extended buffered log mode. This should never
   748			 * happen, since we're never running in extended buffered
   749			 * log mode.
   750			 */
   751			return tape_34xx_erp_retry(request);
   752		case 0x52:
   753			/* End of Volume complete. Rewind unload completed ok. */
   754			if (request->op == TO_RUN) {
   755				tape_med_state_set(device, MS_UNLOADED);
   756				tape_34xx_delete_sbid_from(device, 0);
   757				return tape_34xx_erp_succeeded(request);
   758			}
   759			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   760		case 0x53:
   761			/* Global command intercept. */
   762			return tape_34xx_erp_retry(request);
   763		case 0x54:
   764			/* Channel interface recovery (temporary). */
   765			return tape_34xx_erp_retry(request);
   766		case 0x55:
   767			/* Channel interface recovery (permanent). */
   768			dev_warn (&device->cdev->dev, "A channel interface error cannot be"
   769				" recovered\n");
   770			return tape_34xx_erp_failed(request, -EIO);
   771		case 0x56:
   772			/* Channel protocol error. */
   773			dev_warn (&device->cdev->dev, "A channel protocol error "
   774				"occurred\n");
   775			return tape_34xx_erp_failed(request, -EIO);
   776		case 0x57:
   777			/*
   778			 * 3480: Attention intercept.
   779			 * 3490: Global status intercept.
   780			 */
   781			return tape_34xx_erp_retry(request);
   782		case 0x5a:
   783			/*
   784			 * Tape length incompatible. The tape inserted is too long,
   785			 * which could cause damage to the tape or the drive.
   786			 */
   787			dev_warn (&device->cdev->dev, "The tape unit does not support "
   788				"the tape length\n");
   789			return tape_34xx_erp_failed(request, -EIO);
   790		case 0x5b:
   791			/* Format 3480 XF incompatible */
   792			if (sense[1] & SENSE_BEGINNING_OF_TAPE)
   793				/* The tape will get overwritten. */
   794				return tape_34xx_erp_retry(request);
   795			dev_warn (&device->cdev->dev, "The tape unit does not support"
   796				" format 3480 XF\n");
   797			return tape_34xx_erp_failed(request, -EIO);
   798		case 0x5c:
   799			/* Format 3480-2 XF incompatible */
   800			dev_warn (&device->cdev->dev, "The tape unit does not support tape "
   801				"format 3480-2 XF\n");
   802			return tape_34xx_erp_failed(request, -EIO);
   803		case 0x5d:
   804			/* Tape length violation. */
   805			dev_warn (&device->cdev->dev, "The tape unit does not support"
   806				" the current tape length\n");
   807			return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
   808		case 0x5e:
   809			/* Compaction algorithm incompatible. */
   810			dev_warn (&device->cdev->dev, "The tape unit does not support"
   811				" the compaction algorithm\n");
   812			return tape_34xx_erp_failed(request, -EMEDIUMTYPE);
   813	
   814			/* The following erpas should have been covered earlier. */
   815		case 0x23: /* Read data check. */
   816		case 0x25: /* Write data check. */
   817		case 0x26: /* Data check (read opposite). */
   818		case 0x28: /* Write id mark check. */
   819		case 0x31: /* Tape void. */
   820		case 0x40: /* Overrun error. */
   821		case 0x41: /* Record sequence error. */
   822			/* All other erpas are reserved for future use. */
   823		default:
   824			return tape_34xx_erp_bug(device, request, irb, sense[3]);
   825		}
   826	}
   827	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
