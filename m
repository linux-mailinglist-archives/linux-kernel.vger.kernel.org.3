Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175F249BBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiAYTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:18:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:30633 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbiAYTST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138299; x=1674674299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yxx3Wd/Oulk3FtEv9gN62CsvVj6sGb15bGLewt5QSxA=;
  b=NyAx6lZkV95lbGPnfhrGgxGqyeGLq7Mj+FClF8UKat541/izpcL1efCO
   q1qKQJ4s4mkTc6IS7brmrl5HM8AZ/T0PP1U1LkqgsnDtEs0Qoa+VCEIm/
   NrTwPgYml0kOwttC2QxCHfN4k/jY6tgtD1rPDJn3I7q5/kfwpGvmRwJx9
   i3f4dd8dAH6qEwoBrFPyQP4/l8sN4GcdXI7qLx61o+RHadcjI07l2DXK1
   NoBqpSmQ27hxE9YEVfpDS3cBfB2hUyGpOxpfVzJYfLtUSEfiHMW+Ld5GX
   Q0kYPG20UOwsWyzlTM6I1VPyaDVpN5pJeQbMc53J5DO7U8mbEi/syzqfk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="243991151"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="243991151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="674107412"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2022 11:18:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRKZ-000KMA-Ul; Tue, 25 Jan 2022 19:18:15 +0000
Date:   Wed, 26 Jan 2022 03:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/pci/hda/hda_auto_parser.c:1021:6: warning: %x in format string
 (no. 1) requires 'unsigned int *' but the argument type is 'signed int *'.
 [invalidScanfArgType_int]
Message-ID: <202201260353.d4cl4rJz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a08b41ab9e2e468647f78eb17c28e29b93006394
commit: a235d5b8e550fac7520410440bcc8003fb4cf8d0 ALSA: hda: Allow model option to specify PCI SSID alias
date:   5 months ago
compiler: nds32le-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> sound/pci/hda/hda_auto_parser.c:1021:6: warning: %x in format string (no. 1) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
        sscanf(codec->modelname, "%04x:%04x", &vendor, &device) == 2) {
        ^
   sound/pci/hda/hda_auto_parser.c:1021:6: warning: %x in format string (no. 2) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
        sscanf(codec->modelname, "%04x:%04x", &vendor, &device) == 2) {
        ^

vim +1021 sound/pci/hda/hda_auto_parser.c

   961	
   962	/**
   963	 * snd_hda_pick_fixup - Pick up a fixup matching with PCI/codec SSID or model string
   964	 * @codec: the HDA codec
   965	 * @models: NULL-terminated model string list
   966	 * @quirk: zero-terminated PCI/codec SSID quirk list
   967	 * @fixlist: the fixup list
   968	 *
   969	 * Pick up a fixup entry matching with the given model string or SSID.
   970	 * If a fixup was already set beforehand, the function doesn't do anything.
   971	 * When a special model string "nofixup" is given, also no fixup is applied.
   972	 *
   973	 * The function tries to find the matching model name at first, if given.
   974	 * If the model string contains the SSID alias, try to look up with the given
   975	 * alias ID.
   976	 * If nothing matched, try to look up the PCI SSID.
   977	 * If still nothing matched, try to look up the codec SSID.
   978	 */
   979	void snd_hda_pick_fixup(struct hda_codec *codec,
   980				const struct hda_model_fixup *models,
   981				const struct snd_pci_quirk *quirk,
   982				const struct hda_fixup *fixlist)
   983	{
   984		const struct snd_pci_quirk *q;
   985		int id = HDA_FIXUP_ID_NOT_SET;
   986		const char *name = NULL;
   987		const char *type = NULL;
   988		int vendor, device;
   989	
   990		if (codec->fixup_id != HDA_FIXUP_ID_NOT_SET)
   991			return;
   992	
   993		/* when model=nofixup is given, don't pick up any fixups */
   994		if (codec->modelname && !strcmp(codec->modelname, "nofixup")) {
   995			id = HDA_FIXUP_ID_NO_FIXUP;
   996			fixlist = NULL;
   997			codec_dbg(codec, "%s: picked no fixup (nofixup specified)\n",
   998				  codec->core.chip_name);
   999			goto found;
  1000		}
  1001	
  1002		/* match with the model name string */
  1003		if (codec->modelname && models) {
  1004			while (models->name) {
  1005				if (!strcmp(codec->modelname, models->name)) {
  1006					id = models->id;
  1007					name = models->name;
  1008					codec_dbg(codec, "%s: picked fixup %s (model specified)\n",
  1009						  codec->core.chip_name, codec->fixup_name);
  1010					goto found;
  1011				}
  1012				models++;
  1013			}
  1014		}
  1015	
  1016		if (!quirk)
  1017			return;
  1018	
  1019		/* match with the SSID alias given by the model string "XXXX:YYYY" */
  1020		if (codec->modelname &&
> 1021		    sscanf(codec->modelname, "%04x:%04x", &vendor, &device) == 2) {

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
