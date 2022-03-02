Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41CB4CA81F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiCBOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiCBO3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52AC853B43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646231302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqa8d1eLIJSKOoSwX0YXhFZwEzlx+Ex3/GBzph58jOY=;
        b=eevTMnbu7d+gEQp+VJOL7NUZqLHV2MFTW6NOazxAZWclpedJtOGHYGS3y6HC8TIZ6JKWIV
        RIWm9oTuioZDrOcRJFHlBA69SjMaMkwDMtAx8ydrhVAR2DGZ62dE/Elj5dc15sd8vreZGD
        QtlqMvRLzJTzVgor7CZYVFr2JboAZK4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-r2ses7Q4MECi88exkeMDaA-1; Wed, 02 Mar 2022 09:28:21 -0500
X-MC-Unique: r2ses7Q4MECi88exkeMDaA-1
Received: by mail-ed1-f71.google.com with SMTP id u28-20020a50d51c000000b004159ffb8f24so1092383edi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 06:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tqa8d1eLIJSKOoSwX0YXhFZwEzlx+Ex3/GBzph58jOY=;
        b=l4lMSq9WxydE5NAU0uis994qly6WMAePN8UFAed8ZuPK1F5w95BEvYj/Txc2heJfc1
         mkB1Wrtdh8PkYulRhZXysTRp41A0mFniP4dm7azR2BPjjkGpLtqzXA9lrluaDiEz6mY3
         OwDRuBpRdwjZklpQ6TRPyd0EBKSzC7ZkJEGdP6Meg6y+QK/bQ4Z1F56I5orZm6vlMzgW
         A8q5Du32FT50HQNHVSQrHvnTotxC3+Y0CToMFZg8+m7MV8iaz66Hr1RmKm+ErskKvoqa
         ZB/wWLG0ffCoKCHYphxZK7SkLp11C5eaSPaZuYxQhoWODRXJBk5cRXw1Bc7dupHPj64s
         97sw==
X-Gm-Message-State: AOAM531HOby3UnXzFtRii7JWseLidDd4Q8zt59r3vWs1gIMWQeyFDBoP
        dieXfxtnoqZoe24x9K0yOhvtdsbbV6rEF5s03Ozp+Yy2+jdrUsNA2pE0HAROjB0W5W/kYGDo+xM
        cCk6yUPTuzyBIHCMWebK4ukmF
X-Received: by 2002:a17:907:8a04:b0:6cd:2902:8db3 with SMTP id sc4-20020a1709078a0400b006cd29028db3mr22928327ejc.530.1646231299736;
        Wed, 02 Mar 2022 06:28:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtOkUzA1gnwyd6ZRWmvuXqurq8f9dl4zl/8/+lNQElMUtMiGUdKaoS34uhstCuPoTgx0sg+g==
X-Received: by 2002:a17:907:8a04:b0:6cd:2902:8db3 with SMTP id sc4-20020a1709078a0400b006cd29028db3mr22928300ejc.530.1646231299323;
        Wed, 02 Mar 2022 06:28:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b00415b20902a6sm1140562ede.27.2022.03.02.06.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:28:18 -0800 (PST)
Message-ID: <809b142f-46c4-ad49-21eb-63d34553b1c2@redhat.com>
Date:   Wed, 2 Mar 2022 15:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V9 1/2] tools arch x86: Add Intel SDSi provisiong tool
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220225012457.1661574-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225012457.1661574-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2/25/22 02:24, David E. Box wrote:
> Add tool for key certificate and activation payload provisioning on
> Intel CPUs supporting Software Defined Silicon (SDSi).
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> Applied on review-hans branch.
> 
> V9
>   - In shell script check that python3 exists, not python
>   - In shell script properly catch result of pytest
>   - In test fix check for kmemleak enabled
>   - In test change module name from sdsi to intel_sdsi 
> V8
>   - Rename sdsi to intel_sdsi and add install target
>   - Fix compiler warning for signedness mismatch
>   - Add missing break in CMD_NONE case to avoid fall through
> V7
>   - No changes.
> V6
>   - No changes.
> V5
>   - Update copyright to 2022
> V4
>   - No changes.
> V3
>   - Move from samples to tools.
>   - Fix bit fields in availability structure.
>   - Check provisioning availability before issuing command.
> 
> V2
>   - New patch.
> 
>  MAINTAINERS                            |   1 +
>  tools/arch/x86/intel_sdsi/Makefile     |  21 +
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 558 +++++++++++++++++++++++++
>  3 files changed, 580 insertions(+)
>  create mode 100644 tools/arch/x86/intel_sdsi/Makefile
>  create mode 100644 tools/arch/x86/intel_sdsi/intel_sdsi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a419a6938786..b1281f44a5a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9881,6 +9881,7 @@ INTEL SDSI DRIVER
>  M:	David E. Box <david.e.box@linux.intel.com>
>  S:	Supported
>  F:	drivers/platform/x86/intel/sdsi.c
> +F:	tools/arch/x86/intel_sdsi/
>  
>  INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
>  M:	Daniel Scally <djrscally@gmail.com>
> diff --git a/tools/arch/x86/intel_sdsi/Makefile b/tools/arch/x86/intel_sdsi/Makefile
> new file mode 100644
> index 000000000000..5de2288cda79
> --- /dev/null
> +++ b/tools/arch/x86/intel_sdsi/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for Intel Software Defined Silicon provisioning tool
> +
> +intel_sdsi: intel_sdsi.c
> +
> +CFLAGS = -Wextra
> +
> +BINDIR ?= /usr/sbin
> +
> +override CFLAGS += -O2 -Wall
> +
> +%: %.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
> +
> +.PHONY : clean
> +clean :
> +	@rm -f intel_sdsi
> +
> +install : intel_sdsi
> +	install -d  $(DESTDIR)$(BINDIR)
> +	install -m 755 -p intel_sdsi $(DESTDIR)$(BINDIR)/intel_sdsi
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> new file mode 100644
> index 000000000000..c0e2f2349db4
> --- /dev/null
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -0,0 +1,558 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * sdsi: Intel Software Defined Silicon tool for provisioning certificates
> + * and activation payloads on supported cpus.
> + *
> + * See https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
> + * for register descriptions.
> + *
> + * Copyright (C) 2022 Intel Corporation. All rights reserved.
> + */
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/types.h>
> +
> +#define SDSI_DEV		"intel_vsec.sdsi"
> +#define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
> +#define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
> +#define GUID			0x6dd191
> +#define REGISTERS_MIN_SIZE	72
> +
> +#define __round_mask(x, y) ((__typeof__(x))((y) - 1))
> +#define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> +
> +struct enabled_features {
> +	uint64_t reserved:3;
> +	uint64_t sdsi:1;
> +	uint64_t reserved1:60;
> +};
> +
> +struct auth_fail_count {
> +	uint64_t key_failure_count:3;
> +	uint64_t key_failure_threshold:3;
> +	uint64_t auth_failure_count:3;
> +	uint64_t auth_failure_threshold:3;
> +	uint64_t reserved:52;
> +};
> +
> +struct availability {
> +	uint64_t reserved:48;
> +	uint64_t available:3;
> +	uint64_t threshold:3;
> +};
> +
> +struct sdsi_regs {
> +	uint64_t ppin;
> +	uint64_t reserved;
> +	struct enabled_features en_features;
> +	uint64_t reserved1;
> +	struct auth_fail_count auth_fail_count;
> +	struct availability prov_avail;
> +	uint64_t reserved2;
> +	uint64_t reserved3;
> +	uint64_t socket_id;
> +};
> +
> +struct sdsi_dev {
> +	struct sdsi_regs regs;
> +	char *dev_name;
> +	char *dev_path;
> +	int guid;
> +};
> +
> +enum command {
> +	CMD_NONE,
> +	CMD_SOCKET_INFO,
> +	CMD_DUMP_CERT,
> +	CMD_PROV_AKC,
> +	CMD_PROV_CAP,
> +};
> +
> +static void sdsi_list_devices(void)
> +{
> +	struct dirent *entry;
> +	DIR *aux_dir;
> +	bool found = false;
> +
> +	aux_dir = opendir(AUX_DEV_PATH);
> +	if (!aux_dir) {
> +		fprintf(stderr, "Cannot open directory %s\n", AUX_DEV_PATH);
> +		return;
> +	}
> +
> +	while ((entry = readdir(aux_dir))) {
> +		if (!strncmp(SDSI_DEV, entry->d_name, strlen(SDSI_DEV))) {
> +			found = true;
> +			printf("%s\n", entry->d_name);
> +		}
> +	}
> +
> +	if (!found)
> +		fprintf(stderr, "No sdsi devices found.\n");
> +}
> +
> +static int sdsi_update_registers(struct sdsi_dev *s)
> +{
> +	FILE *regs_ptr;
> +	int ret;
> +
> +	memset(&s->regs, 0, sizeof(s->regs));
> +
> +	/* Open the registers file */
> +	ret = chdir(s->dev_path);
> +	if (ret == -1) {
> +		perror("chdir");
> +		return ret;
> +	}
> +
> +	regs_ptr = fopen("registers", "r");
> +	if (!regs_ptr) {
> +		perror("Could not open 'registers' file");
> +		return -1;
> +	}
> +
> +	if (s->guid != GUID) {
> +		fprintf(stderr, "Unrecognized guid, 0x%x\n", s->guid);
> +		fclose(regs_ptr);
> +		return -1;
> +	}
> +
> +	/* Update register info for this guid */
> +	ret = fread(&s->regs, sizeof(uint8_t), sizeof(s->regs), regs_ptr);
> +	if (ret != sizeof(s->regs)) {
> +		fprintf(stderr, "Could not read 'registers' file\n");
> +		fclose(regs_ptr);
> +		return -1;
> +	}
> +
> +	fclose(regs_ptr);
> +
> +	return 0;
> +}
> +
> +static int sdsi_read_reg(struct sdsi_dev *s)
> +{
> +	int ret;
> +
> +	ret = sdsi_update_registers(s);
> +	if (ret)
> +		return ret;
> +
> +	/* Print register info for this guid */
> +	printf("\n");
> +	printf("Socket information for device %s\n", s->dev_name);
> +	printf("\n");
> +	printf("PPIN:                           0x%lx\n", s->regs.ppin);
> +	printf("Enabled Features\n");
> +	printf("    SDSi:                       %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
> +	printf("Authorization Failure Count\n");
> +	printf("    AKC Failure Count:          %d\n", s->regs.auth_fail_count.key_failure_count);
> +	printf("    AKC Failure Threshold:      %d\n", s->regs.auth_fail_count.key_failure_threshold);
> +	printf("    CAP Failure Count:          %d\n", s->regs.auth_fail_count.auth_failure_count);
> +	printf("    CAP Failure Threshold:      %d\n", s->regs.auth_fail_count.auth_failure_threshold);
> +	printf("Provisioning Availability\n");
> +	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
> +	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
> +	printf("Socket ID:                      %ld\n", s->regs.socket_id & 0xF);
> +
> +	return 0;
> +}
> +
> +static int sdsi_certificate_dump(struct sdsi_dev *s)
> +{
> +	uint64_t state_certificate[512] = {0};
> +	bool first_instance;
> +	uint64_t previous;
> +	FILE *cert_ptr;
> +	int i, ret, size;
> +
> +	ret = sdsi_update_registers(s);
> +	if (ret)
> +		return ret;
> +
> +	if (!s->regs.en_features.sdsi) {
> +		fprintf(stderr, "SDSi feature is present but not enabled.");
> +		fprintf(stderr, " Unable to read state certificate");
> +		return -1;
> +	}
> +
> +	ret = chdir(s->dev_path);
> +	if (ret == -1) {
> +		perror("chdir");
> +		return ret;
> +	}
> +
> +	cert_ptr = fopen("state_certificate", "r");
> +	if (!cert_ptr) {
> +		perror("Could not open 'state_certificate' file");
> +		return -1;
> +	}
> +
> +	size = fread(state_certificate, 1, sizeof(state_certificate), cert_ptr);
> +	if (!size) {
> +		fprintf(stderr, "Could not read 'state_certificate' file\n");
> +		fclose(cert_ptr);
> +		return -1;
> +	}
> +
> +	printf("%3d: 0x%lx\n", 0, state_certificate[0]);
> +	previous = state_certificate[0];
> +	first_instance = true;
> +
> +	for (i = 1; i < (int)(round_up(size, sizeof(uint64_t))/sizeof(uint64_t)); i++) {
> +		if (state_certificate[i] == previous) {
> +			if (first_instance) {
> +				puts("*");
> +				first_instance = false;
> +			}
> +			continue;
> +		}
> +		printf("%3d: 0x%lx\n", i, state_certificate[i]);
> +		previous = state_certificate[i];
> +		first_instance = true;
> +	}
> +	printf("%3d\n", i);
> +
> +	fclose(cert_ptr);
> +
> +	return 0;
> +}
> +
> +static int sdsi_provision(struct sdsi_dev *s, char *bin_file, enum command command)
> +{
> +	int bin_fd, prov_fd, size, ret;
> +	char buf[4096] = { 0 };
> +	char cap[] = "provision_cap";
> +	char akc[] = "provision_akc";
> +	char *prov_file;
> +
> +	if (!bin_file) {
> +		fprintf(stderr, "No binary file provided\n");
> +		return -1;
> +	}
> +
> +	/* Open the binary */
> +	bin_fd = open(bin_file, O_RDONLY);
> +	if (bin_fd == -1) {
> +		fprintf(stderr, "Could not open file %s: %s\n", bin_file, strerror(errno));
> +		return bin_fd;
> +	}
> +
> +	prov_file = (command == CMD_PROV_AKC) ? akc : cap;
> +
> +	ret = chdir(s->dev_path);
> +	if (ret == -1) {
> +		perror("chdir");
> +		close(bin_fd);
> +		return ret;
> +	}
> +
> +	/* Open the provision file */
> +	prov_fd = open(prov_file, O_WRONLY);
> +	if (prov_fd == -1) {
> +		fprintf(stderr, "Could not open file %s: %s\n", prov_file, strerror(errno));
> +		close(bin_fd);
> +		return prov_fd;
> +	}
> +
> +	/* Read the binary file into the buffer */
> +	size = read(bin_fd, buf, 4096);
> +	if (size == -1) {
> +		close(bin_fd);
> +		close(prov_fd);
> +		return -1;
> +	}
> +
> +	ret = write(prov_fd, buf, size);
> +	if (ret == -1) {
> +		close(bin_fd);
> +		close(prov_fd);
> +		perror("Provisioning failed");
> +		return ret;
> +	}
> +
> +	printf("Provisioned %s file %s successfully\n", prov_file, bin_file);
> +
> +	close(bin_fd);
> +	close(prov_fd);
> +
> +	return 0;
> +}
> +
> +static int sdsi_provision_akc(struct sdsi_dev *s, char *bin_file)
> +{
> +	int ret;
> +
> +	ret = sdsi_update_registers(s);
> +	if (ret)
> +		return ret;
> +
> +	if (!s->regs.en_features.sdsi) {
> +		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
> +		return -1;
> +	}
> +
> +	if (!s->regs.prov_avail.available) {
> +		fprintf(stderr, "Maximum number of updates (%d) has been reached.\n",
> +			s->regs.prov_avail.threshold);
> +		return -1;
> +	}
> +
> +	if (s->regs.auth_fail_count.key_failure_count ==
> +	    s->regs.auth_fail_count.key_failure_threshold) {
> +		fprintf(stderr, "Maximum number of AKC provision failures (%d) has been reached.\n",
> +			s->regs.auth_fail_count.key_failure_threshold);
> +		fprintf(stderr, "Power cycle the system to reset the counter\n");
> +		return -1;
> +	}
> +
> +	return sdsi_provision(s, bin_file, CMD_PROV_AKC);
> +}
> +
> +static int sdsi_provision_cap(struct sdsi_dev *s, char *bin_file)
> +{
> +	int ret;
> +
> +	ret = sdsi_update_registers(s);
> +	if (ret)
> +		return ret;
> +
> +	if (!s->regs.en_features.sdsi) {
> +		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
> +		return -1;
> +	}
> +
> +	if (!s->regs.prov_avail.available) {
> +		fprintf(stderr, "Maximum number of updates (%d) has been reached.\n",
> +			s->regs.prov_avail.threshold);
> +		return -1;
> +	}
> +
> +	if (s->regs.auth_fail_count.auth_failure_count ==
> +	    s->regs.auth_fail_count.auth_failure_threshold) {
> +		fprintf(stderr, "Maximum number of CAP provision failures (%d) has been reached.\n",
> +			s->regs.auth_fail_count.auth_failure_threshold);
> +		fprintf(stderr, "Power cycle the system to reset the counter\n");
> +		return -1;
> +	}
> +
> +	return sdsi_provision(s, bin_file, CMD_PROV_CAP);
> +}
> +
> +static int read_sysfs_data(const char *file, int *value)
> +{
> +	char buff[16];
> +	FILE *fp;
> +
> +	fp = fopen(file, "r");
> +	if (!fp) {
> +		perror(file);
> +		return -1;
> +	}
> +
> +	if (!fgets(buff, 16, fp)) {
> +		fprintf(stderr, "Failed to read file '%s'", file);
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +	*value = strtol(buff, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static struct sdsi_dev *sdsi_create_dev(char *dev_no)
> +{
> +	int dev_name_len = sizeof(SDSI_DEV) + strlen(dev_no) + 1;
> +	struct sdsi_dev *s;
> +	int guid;
> +	DIR *dir;
> +
> +	s = (struct sdsi_dev *)malloc(sizeof(*s));
> +	if (!s) {
> +		perror("malloc");
> +		return NULL;
> +	}
> +
> +	s->dev_name = (char *)malloc(sizeof(SDSI_DEV) + strlen(dev_no) + 1);
> +	if (!s->dev_name) {
> +		perror("malloc");
> +		free(s);
> +		return NULL;
> +	}
> +
> +	snprintf(s->dev_name, dev_name_len, "%s.%s", SDSI_DEV, dev_no);
> +
> +	s->dev_path = (char *)malloc(sizeof(AUX_DEV_PATH) + dev_name_len);
> +	if (!s->dev_path) {
> +		perror("malloc");
> +		free(s->dev_name);
> +		free(s);
> +		return NULL;
> +	}
> +
> +	snprintf(s->dev_path, sizeof(AUX_DEV_PATH) + dev_name_len, "%s%s", AUX_DEV_PATH,
> +		 s->dev_name);
> +	dir = opendir(s->dev_path);
> +	if (!dir) {
> +		fprintf(stderr, "Could not open directory '%s': %s\n", s->dev_path,
> +			strerror(errno));
> +		free(s->dev_path);
> +		free(s->dev_name);
> +		free(s);
> +		return NULL;
> +	}
> +
> +	if (chdir(s->dev_path) == -1) {
> +		perror("chdir");
> +		free(s->dev_path);
> +		free(s->dev_name);
> +		free(s);
> +		return NULL;
> +	}
> +
> +	if (read_sysfs_data("guid", &guid)) {
> +		free(s->dev_path);
> +		free(s->dev_name);
> +		free(s);
> +		return NULL;
> +	}
> +
> +	s->guid = guid;
> +
> +	return s;
> +}
> +
> +static void sdsi_free_dev(struct sdsi_dev *s)
> +{
> +	free(s->dev_path);
> +	free(s->dev_name);
> +	free(s);
> +}
> +
> +static void usage(char *prog)
> +{
> +	printf("Usage: %s [-l] [-d DEVNO [-iD] [-a FILE] [-c FILE]]\n", prog);
> +}
> +
> +static void show_help(void)
> +{
> +	printf("Commands:\n");
> +	printf("  %-18s\t%s\n", "-l, --list",		"list available sdsi devices");
> +	printf("  %-18s\t%s\n", "-d, --devno DEVNO",	"sdsi device number");
> +	printf("  %-18s\t%s\n", "-i --info",		"show socket information");
> +	printf("  %-18s\t%s\n", "-D --dump",		"dump state certificate data");
> +	printf("  %-18s\t%s\n", "-a --akc FILE",	"provision socket with AKC FILE");
> +	printf("  %-18s\t%s\n", "-c --cap FILE>",	"provision socket with CAP FILE");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char bin_file[PATH_MAX], *dev_no = NULL;
> +	char *progname;
> +	enum command command = CMD_NONE;
> +	struct sdsi_dev *s;
> +	int ret = 0, opt;
> +	int option_index = 0;
> +
> +	static struct option long_options[] = {
> +		{"akc",		required_argument,	0, 'a'},
> +		{"cap",		required_argument,	0, 'c'},
> +		{"devno",	required_argument,	0, 'd'},
> +		{"dump",	no_argument,		0, 'D'},
> +		{"help",	no_argument,		0, 'h'},
> +		{"info",	no_argument,		0, 'i'},
> +		{"list",	no_argument,		0, 'l'},
> +		{0,		0,			0, 0 }
> +	};
> +
> +
> +	progname = argv[0];
> +
> +	while ((opt = getopt_long_only(argc, argv, "+a:c:d:Da:c:h", long_options,
> +			&option_index)) != -1) {
> +		switch (opt) {
> +		case 'd':
> +			dev_no = optarg;
> +			break;
> +		case 'l':
> +			sdsi_list_devices();
> +			return 0;
> +		case 'i':
> +			command = CMD_SOCKET_INFO;
> +			break;
> +		case 'D':
> +			command = CMD_DUMP_CERT;
> +			break;
> +		case 'a':
> +		case 'c':
> +			if (!access(optarg, F_OK) == 0) {
> +				fprintf(stderr, "Could not open file '%s': %s\n", optarg,
> +					strerror(errno));
> +				return -1;
> +			}
> +
> +			if (!realpath(optarg, bin_file)) {
> +				perror("realpath");
> +				return -1;
> +			}
> +
> +			command = (opt == 'a') ? CMD_PROV_AKC : CMD_PROV_CAP;
> +			break;
> +		case 'h':
> +			usage(progname);
> +			show_help();
> +			return 0;
> +		default:
> +			usage(progname);
> +			return -1;
> +		}
> +	}
> +
> +	if (!dev_no) {
> +		if (command != CMD_NONE)
> +			fprintf(stderr, "Missing device number, DEVNO, for this command\n");
> +		usage(progname);
> +		return -1;
> +	}
> +
> +	s = sdsi_create_dev(dev_no);
> +	if (!s)
> +		return -1;
> +
> +	/* Run the command */
> +	switch (command) {
> +	case CMD_NONE:
> +		fprintf(stderr, "Missing command for device %s\n", dev_no);
> +		usage(progname);
> +		break;
> +	case CMD_SOCKET_INFO:
> +		ret = sdsi_read_reg(s);
> +		break;
> +	case CMD_DUMP_CERT:
> +		ret = sdsi_certificate_dump(s);
> +		break;
> +	case CMD_PROV_AKC:
> +		ret = sdsi_provision_akc(s, bin_file);
> +		break;
> +	case CMD_PROV_CAP:
> +		ret = sdsi_provision_cap(s, bin_file);
> +		break;
> +	}
> +
> +
> +	sdsi_free_dev(s);
> +
> +	return ret;
> +}
> 
> base-commit: 555a28b9ab1c2a83577bc58e24a63c9716e36561

