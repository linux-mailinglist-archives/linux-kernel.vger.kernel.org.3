Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F54EA1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbiC1Uq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC3674C4;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B6AEB81212;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DCFC3410F;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=bhjIYrP1LIUYHqVqwO9fRvylmwAunjFXsaJ23BiEGqA=;
        h=From:To:Cc:Subject:Date:From;
        b=GovG5HsDQ4D8az97d54Km7h5AMXTWG1jPG8BBqU4m7W8PKWIWQDaFv3KNilsJFu+w
         r6PT4f0ZHz1KMOwLZYHLXCFTezk981XP/jP4tpRP+lNSDedzrdVkNFWF8sLfFeCpWz
         yGcm+G7UnX4/Mmh+FSqycxBuc3HpVPO3S/UK5QX2SzH7oA2m52dJLAsOveXgJFFRpZ
         o0JOnOh1U2XjKNBI2HXO9ym/tr16EBpSnRA0fG8lcj1UUL8xDssF30NWcymiaYmmf6
         t5rVUtXDpXdXSuzVNXzg/y+o0v7oYn1fS0UqHd3wwlx70A7y41aa54lyro8r09G4Ji
         ognzsVS/3DS4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBH-000lbp-SV; Mon, 28 Mar 2022 22:41:39 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 00/26] dvb-usb: use designated initializers
Date:   Mon, 28 Mar 2022 22:41:12 +0200
Message-Id: <cover.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two DVB USB cores on media. The new one (dvb-usb-v2)
solves several problems with the previous one, but, unfortunately,
there are several drivers that weren't migrated yet.

One of the problems with dvb-usb is that, besides the common
DVB USB table, it also uses a per-device table which require
links to the USB ID table.

This is done, on most drivers, using a magic number, which is easy
to get outdated.

Rewrite the drivers in order to use an enum and use designated
initializers where needed.

This patch series was inspired on this patch:
  https://patchwork.kernel.org/project/linux-media/patch/20220326165909.506926-16-benni@stuerz.xyz/

While it would be nice to also change the tables to be const, this
is currently not possible, as a couple drivers that depend on the
dvb-usb struct depend on it to not be const.

Writing a patch series like that and making it properly referencing
the right entries is not fun. That's most drivers were never fixed.
So, I ended using a script to change it, adding several checks on
it, in order to avoid the risk of problems.

Even so, I needed to manually adjust some patches.

This is the used script:

<script>
#!/usr/bin/perl
use strict;
use warnings;
use Text::Tabs;
use File::Find;

my $usb_id_pre = "";
my $usb_id_end = "";

my %vid;
my %pid;

my %pid_count;

my $state = "pre";

sub out_ids()
{
	open OUT, "> include/media/dvb-usb-ids.h" or die;
	print OUT $usb_id_pre;
	foreach my $k(sort keys %vid) {
		my $ln = sprintf "#define USB_VID_%-31s %s\n", $k, $vid{$k};
		$ln = unexpand($ln);
		print OUT $ln;
	}

	print OUT "\n/* Product IDs */\n\n";
	foreach my $k(sort keys %pid) {
		my $ln = sprintf "#define USB_PID_%-39s %s\n", $k, $pid{$k};
		$ln = unexpand($ln);
		print OUT $ln;
	}
	print OUT $usb_id_end;
	close OUT;
}

my @enum;

sub validate_model($$)
{
	my $my_vid = $1;
	my $my_pid = $2;

	if (!$vid{$my_vid}) {
		print "$.# ERROR! VID: $my_vid\n";
		return "";
	}

	if (!$pid{$my_pid}) {
		print "$.# ERROR! PID: $my_pid\n";
		return "";
	}

	my $tmp_vid = $my_vid;
	$tmp_vid =~ s/_ELECTRONIC$//;
	$tmp_vid =~ s/_MICRO$//;
	$tmp_vid =~ s/_1$//;
	$tmp_vid =~ s/_2$//;
	$tmp_vid =~ s/_UNK$//;
	$tmp_vid =~ s/GTEK/GENIATECH/;

	# Change model name to be different
	my $model = $tmp_vid . "_" . $my_pid;

	return $my_pid if ($my_pid =~ /$tmp_vid[_]/ && !grep(/^$my_pid$/, @enum));

	print "NEW model: $model\n";

	# Add the new PID to include/media/dvb-usb-ids.h
	$pid{$model} = $pid{$my_pid};

	$pid_count{$my_pid}--;

	# Drop unused PIDs
	if (!$pid_count{$my_pid}) {
		delete ($pid{$my_pid});
		print "Drop: $my_pid\n";
	}

	return $model if (!grep(/^$model$/, @enum));

	print "$.# ERROR! Model $model aready exists\n";
	return "";
}

sub count_pid()
{
	my $file = $File::Find::name;

	return if (!($file =~ /[.][ch]/));

	open IN, $file or die "Can't open $file";
	while (<IN>) {
		if (/USB_PID_([\w\_]+)/) {
			$pid_count{$1}++;
			next;
		}
	}
	close IN;
}

open IN, "include/media/dvb-usb-ids.h" or die;
while (<IN>) {
	if (/#define\s+USB_VID_(\S+)\s+(\S+)/) {
		$state = "vid";
		$vid{$1} = $2;
#print "VID: $1 -> $2\n";
		next;
	}
	if (/#define\s+USB_PID_(\S+)\s+(\S+)/) {
		$state = "pid";
		$pid{$1} = $2;
#print "PID: $1 -> $2\n";
		next;
	}

	if ($state eq "pre") {
		$usb_id_pre .= $_;
	} elsif ($state eq "pid") {
		$usb_id_end .= $_;
	}
}
close IN;

find({wanted => \&count_pid, no_chdir => 1}, "drivers/media/usb/");


while (scalar @ARGV) {
	@enum = ();
	my @dev_id;


	my $usb_dev_id_table;
	my $out = "";
	my $should_write = 1;

	my $file = $ARGV[0];

	print "Processing $file...\n";

	open IN, $file or die "Can't open $1";

	my $entry = "";

	my $pos = 0;

	while (<IN>) {
		if (m/struct\s.*usb_device_id\s+([\w\_]+).*{/) {
			$usb_dev_id_table = $1;
		}
		if (!$usb_dev_id_table) {
			$out .= $_;
			next;
		}

		if (m,\/\*\s*(\d+)\s*\*\/,) {
			if ($1 != $pos) {
				printf "$.# ERROR! Count is wrong! Want %d, got %d\n", $pos, $1;
				$should_write = 0;
				last;
			}
		}

		$pos++ if (m/USB_DEVICE/);

		last if (m/^}\s*;/);

		$entry .= $_;
		next if (!(m/}\s*,/));

		if ($entry =~ m/USB_DEVICE\(USB_VID_([\w\_]+)\s*,\s*USB_PID_([\w\_]+)/) {
			my $my_vid = $1;
			my $my_pid = $2;

			my $model = validate_model($my_vid, $my_pid);
			if ($model eq "") {
				$should_write = 0;
				last;
			}

			push @enum, $model;
			push @dev_id, "DVB_USB_DEV($my_vid, $model)";
			print "DVB_USB_DEV($my_vid, $model)\n";
		}
		if ($entry =~ m/USB_DEVICE_VER\(USB_VID_([\w\_]+)\s*,\s*USB_PID_([\w\_]+)\s*,\s*(\w+)\s*,\s*(\w+)/) {
			my $my_vid = $1;
			my $my_pid = $2;
			my $lo = $3;
			my $hi = $4;

			my $model = validate_model($my_vid, $my_pid);
			if ($model eq "") {
				$should_write = 0;
				last;
			}

			push @enum, $model;
			push @dev_id, "DVB_USB_DEV_VER($my_vid, $model, $lo, $hi)";
			print "DVB_USB_DEV_VER($my_vid, $model, $lo, $hi)\n";
		}
		$entry = "";
	}

	if ($should_write && scalar(@enum) != $pos) {
		printf "ERROR! Count is wrong! Want %d, got %d\n", $pos, scalar(@enum);
		$should_write = 0;
	}

	if ($usb_dev_id_table && $should_write) {
		$out .= "enum {\n";
		for my $e (@enum) {
			$out .= "\t$e,\n";
		}
		$out .= "};\n\n";

		$out .= "static struct usb_device_id $usb_dev_id_table\[\] = {\n";
		for my $e (@dev_id) {
			$out .= "\t$e,\n";
		}
		$out .= "\t{ }\n";
		$out .= "};\n\n";

		my $start = 1;

		while (<IN>) {
			next if ($start && m/^$/);
			$start = 0;
			while (m/$usb_dev_id_table\[(\d+)\]/g) {
				my $i = $1;

				if ($1 > scalar @enum) {
					print "ERROR! $usb_dev_id_table element $1 doesn't exist!\n";
					$should_write = 0;
					last;
				}

				my $idx = $enum[$1];

				if (!(s,($usb_dev_id_table)\[$i\],$1\[$idx],g)) {
					print "ERROR! can't replace $1!\n";
					$should_write = 0;
					last;
				}
			}
			$out .= $_;
		}
		close IN;
	} else {
		while (<IN>) {
			$out .= $_;
		}
		print "\tunchanged\n";
		$should_write = 0;
	}

	if ($should_write || $file eq "include/media/dvb-usb-ids.h") {
		open OUT, ">$file" or die "Can't write on file $file";
		print OUT $out;
		close OUT;
		printf "\twrote\n";

		out_ids();
	}

	shift @ARGV;
}
</script>


Mauro Carvalho Chehab (26):
  media: dvb-usb-ids.h: sort entries
  media: dvb-usb: move USB IDs to dvb-usb-ids.h
  media: dvb-usb: vp702x: reference to usb ID table
  media: dvb-usb: Add helper macros for using USB VID/PID
  media: dvb-usb: a800: use an enum for the device number
  media: af9005: use the newer dvb-usb macros for USB device
  media: dvb-usb: az6027: use an enum for the device number
  media: cinergyT2-core: use the newer dvb-usb macros for USB device
  media: cxusb: use the newer dvb-usb macros for USB device
  media: digitv: use the newer dvb-usb macros for USB device
  media: dvb-usb: dtt200u: use an enum for the device number
  media: dtv5100: use the newer dvb-usb macros for USB device
  media: dw2102: use the newer dvb-usb macros for USB device
  media: dvb-usb: gp8psk: use an enum for the device number
  media: dvb-usb: m920x: use an enum for the device number
  media: dvb-usb: nova-t-usb2: use an enum for the device number
  media: dvb-usb: opera1: use an enum for the device number
  media: dvb-usb: pctv452e: use an enum for the device number
  media: technisat-usb2: use the newer dvb-usb macros for USB device
  media: dvb-usb: ttusb2: use an enum for the device number
  media: dvb-usb: umt-010: use an enum for the device number
  media: dvb-usb: vp702x: use an enum for the device number
  media: dvb-usb: vp7045: use an enum for the device number
  media: dvb-usb: dibusb-mb: use an enum for the device number
  media: dvb-usb: dibusb-mc: use an enum for the device number
  media: dvb-usb: dib0700_devices: use an enum for the device number

 drivers/media/usb/dvb-usb/a800.c            |  18 +-
 drivers/media/usb/dvb-usb/af9005.c          |  19 +-
 drivers/media/usb/dvb-usb/az6027.c          |  45 +-
 drivers/media/usb/dvb-usb/cinergyT2-core.c  |  10 +-
 drivers/media/usb/dvb-usb/cxusb.c           |  88 +--
 drivers/media/usb/dvb-usb/dib0700_devices.c | 428 +++++++------
 drivers/media/usb/dvb-usb/dibusb-mb.c       | 165 ++---
 drivers/media/usb/dvb-usb/dibusb-mc.c       |  88 +--
 drivers/media/usb/dvb-usb/digitv.c          |  13 +-
 drivers/media/usb/dvb-usb/dtt200u.c         |  56 +-
 drivers/media/usb/dvb-usb/dtv5100.c         |  11 +-
 drivers/media/usb/dvb-usb/dw2102.c          |  84 ++-
 drivers/media/usb/dvb-usb/gp8psk.c          |  36 +-
 drivers/media/usb/dvb-usb/m920x.c           |  51 +-
 drivers/media/usb/dvb-usb/nova-t-usb2.c     |  18 +-
 drivers/media/usb/dvb-usb/opera1.c          |  15 +-
 drivers/media/usb/dvb-usb/pctv452e.c        |  22 +-
 drivers/media/usb/dvb-usb/technisat-usb2.c  |  11 +-
 drivers/media/usb/dvb-usb/ttusb2.c          |  36 +-
 drivers/media/usb/dvb-usb/umt-010.c         |  18 +-
 drivers/media/usb/dvb-usb/vp702x.c          |  23 +-
 drivers/media/usb/dvb-usb/vp7045.c          |  28 +-
 include/media/dvb-usb-ids.h                 | 632 +++++++++++---------
 23 files changed, 1071 insertions(+), 844 deletions(-)

-- 
2.35.1


