Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84BA46C3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhLGTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:55:46 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37526 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhLGTzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:55:46 -0500
Received: by mail-ot1-f53.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so299440otg.4;
        Tue, 07 Dec 2021 11:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKssFf2gCgnfRE7Q86SOukAM/1K+ofpM0kTXgBJYrI4=;
        b=jKgQHSMIU7COlOPOP7WrteDhfVWD++l0YsCGFWA8mZrde+DFtGglOx3mpjziaes1sB
         VrbVXHFgDtr7gibDhiAjnl7CauiphDIDTKtcNauzWwHxdnIME3KvAtNye2xt42/Owo/3
         o/PmCWLltV7S3fa3hFB9HnLhSw4Zwt69ITvS9fcAtNnBOE2u5j1cOMqJ+Vw2pfn5x2lm
         2uuwi6ekVZCJ7+bP9FxL5jlfWRjNYzKIAtXB8IbLiMqeO4dZnTa1bRMWPFPJJ3UwVusB
         qGxOdFNqLMp/93zbnikNVdtDP3L6D58NtcQRwmQifgMy+oxdn/MuG5OODk0G9TjXVCRP
         zVzw==
X-Gm-Message-State: AOAM533URXg94BJLSS9vwDgQOzzI4zxjVUs7x95Q8OsGeAzhWDEZvznI
        VKCeUPfNSlFubYCwafPcdBm+L93TEZMN8DPQ8Jkxdi/n
X-Google-Smtp-Source: ABdhPJyayFXY05OtaCXGU3ivsqgn141eiOeR8z1HWP2HtQZAx1VRiOV3WZZn/25r1uI2jh8o/ufi0Ooqv19iVuvq49A=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr37183929otf.198.1638906734863;
 Tue, 07 Dec 2021 11:52:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637505679.git.yu.c.chen@intel.com> <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
In-Reply-To: <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Dec 2021 20:52:03 +0100
Message-ID: <CAJZ5v0gLXxvzKcjSFH0Coq_VRE9fiT9AiCD_vsg7x1Gaq62V+A@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] tools: Introduce power/acpi/tools/pfru
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 4:18 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Introduce a user space tool to make use of the interface exposed by
> Platform Firmware Runtime Update and Telemetry drivers. The users
> can use this tool to do firmware code injection, driver update and
> to retrieve the telemetry data.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v11:No change since v10.
> v10:No change since v9.
> v9: Add this tool into tools/power/acpi build infrastructure.
>     (Andy Shevchenko)
> v8: Print the length of OEM information if requested.
> v7: No change since v6.
> v6: Simplify the userspace tool to use while loop for getopt_long().
>     (Andy Shevchenko)
> v5: Replace the read() with mmap() so that the userspace
>     could mmap once, and read multiple times. (Greg Kroah-Hartman)
> ---
>  tools/power/acpi/.gitignore          |   1 +
>  tools/power/acpi/Makefile            |  16 +-
>  tools/power/acpi/Makefile.rules      |   2 +-
>  tools/power/acpi/man/pfru.8          | 137 +++++++++

I would call it pfrut, because it is for both the update and telemetry
retrieval.

>  tools/power/acpi/tools/pfru/Makefile |  23 ++
>  tools/power/acpi/tools/pfru/pfru.c   | 417 +++++++++++++++++++++++++++
>  6 files changed, 587 insertions(+), 9 deletions(-)
>  create mode 100644 tools/power/acpi/man/pfru.8
>  create mode 100644 tools/power/acpi/tools/pfru/Makefile
>  create mode 100644 tools/power/acpi/tools/pfru/pfru.c
>
> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> index 0b319fc8bb17..a6f196912999 100644
> --- a/tools/power/acpi/.gitignore
> +++ b/tools/power/acpi/.gitignore
> @@ -2,4 +2,5 @@
>  /acpidbg
>  /acpidump
>  /ec
> +/pfru
>  /include/
> diff --git a/tools/power/acpi/Makefile b/tools/power/acpi/Makefile
> index a249c50ebf55..2fcf09d3add3 100644
> --- a/tools/power/acpi/Makefile
> +++ b/tools/power/acpi/Makefile
> @@ -9,18 +9,18 @@ include ../../scripts/Makefile.include
>
>  .NOTPARALLEL:
>
> -all: acpidbg acpidump ec
> -clean: acpidbg_clean acpidump_clean ec_clean
> -install: acpidbg_install acpidump_install ec_install
> -uninstall: acpidbg_uninstall acpidump_uninstall ec_uninstall
> +all: acpidbg acpidump ec pfru
> +clean: acpidbg_clean acpidump_clean ec_clean pfru_clean
> +install: acpidbg_install acpidump_install ec_install pfru_install
> +uninstall: acpidbg_uninstall acpidump_uninstall ec_uninstall pfru_uninstall
>
> -acpidbg acpidump ec: FORCE
> +acpidbg acpidump ec pfru: FORCE
>         $(call descend,tools/$@,all)
> -acpidbg_clean acpidump_clean ec_clean:
> +acpidbg_clean acpidump_clean ec_clean pfru_clean:
>         $(call descend,tools/$(@:_clean=),clean)
> -acpidbg_install acpidump_install ec_install:
> +acpidbg_install acpidump_install ec_install pfru_install:
>         $(call descend,tools/$(@:_install=),install)
> -acpidbg_uninstall acpidump_uninstall ec_uninstall:
> +acpidbg_uninstall acpidump_uninstall ec_uninstall pfru_uninstall:
>         $(call descend,tools/$(@:_uninstall=),uninstall)
>
>  .PHONY: FORCE
> diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
> index 2a6c170b57cd..68aa7e92d554 100644
> --- a/tools/power/acpi/Makefile.rules
> +++ b/tools/power/acpi/Makefile.rules
> @@ -9,7 +9,7 @@ objdir := $(OUTPUT)tools/$(TOOL)/
>  toolobjs := $(addprefix $(objdir),$(TOOL_OBJS))
>  $(OUTPUT)$(TOOL): $(toolobjs) FORCE
>         $(ECHO) "  LD      " $(subst $(OUTPUT),,$@)
> -       $(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(toolobjs) -L$(OUTPUT) -o $@
> +       $(QUIET) $(LD) $(CFLAGS) $(toolobjs) $(LDFLAGS) -L$(OUTPUT) -o $@
>         $(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
>         $(QUIET) $(STRIPCMD) $@
>
> diff --git a/tools/power/acpi/man/pfru.8 b/tools/power/acpi/man/pfru.8
> new file mode 100644
> index 000000000000..d9cda7beaa3c
> --- /dev/null
> +++ b/tools/power/acpi/man/pfru.8
> @@ -0,0 +1,137 @@
> +.TH "PFRU" "8" "October 2021" "pfru 1.0" ""
> +.hy
> +.SH Name
> +.PP
> +pfru \- Platform Firmware Runtime Update tool
> +.SH SYNOPSIS
> +.PP
> +\f[B]pfru\f[R] [\f[I]Options\f[R]]
> +.SH DESCRIPTION
> +.PP
> +The PFRU(Platform Firmware Runtime Update) kernel interface is designed
> +to
> +.PD 0
> +.P
> +.PD
> +interact with the platform firmware interface defined in the
> +.PD 0
> +.P
> +.PD
> +Management Mode Firmware Runtime
> +Update (https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf)
> +.PD 0
> +.P
> +.PD
> +\f[B]pfru\f[R] is the tool to interact with the kernel interface.
> +.PD 0
> +.P
> +.PD
> +.SH OPTIONS
> +.TP
> +.B \f[B]\-h\f[R], \f[B]\-\-help\f[R]
> +Display helper information.
> +.TP
> +.B \f[B]\-l\f[R], \f[B]\-\-load\f[R]
> +Load the capsule file into the system.
> +To be more specific, the capsule file will be copied to the
> +communication buffer.
> +.TP
> +.B \f[B]\-s\f[R], \f[B]\-\-stage\f[R]
> +Stage the capsule image from communication buffer into Management Mode
> +and perform authentication.
> +.TP
> +.B \f[B]\-a\f[R], \f[B]\-\-activate\f[R]
> +Activate a previous staged capsule image.
> +.TP
> +.B \f[B]\-u\f[R], \f[B]\-\-update\f[R]
> +Perform both stage and activation actions.
> +.TP
> +.B \f[B]\-q\f[R], \f[B]\-\-query\f[R]
> +Query the update capability.
> +.TP
> +.B \f[B]\-d\f[R], \f[B]\-\-setrev\f[R]
> +Set the revision ID of code injection/driver update.
> +.TP
> +.B \f[B]\-D\f[R], \f[B]\-\-setrevlog\f[R]
> +Set the revision ID of telemetry.
> +.TP
> +.B \f[B]\-G\f[R], \f[B]\-\-getloginfo\f[R]
> +Get telemetry log information and print it out.
> +.TP
> +.B \f[B]\-T\f[R], \f[B]\-\-type\f[R]
> +Set the telemetry log data type.
> +.TP
> +.B \f[B]\-L\f[R], \f[B]\-\-level\f[R]
> +Set the telemetry log level.
> +.TP
> +.B \f[B]\-R\f[R], \f[B]\-\-read\f[R]
> +Read all the telemetry data and print it out.
> +.SH EXAMPLES
> +.PP
> +\f[B]pfru \-G\f[R]
> +.PP
> +log_level:4
> +.PD 0
> +.P
> +.PD
> +log_type:0
> +.PD 0
> +.P
> +.PD
> +log_revid:2
> +.PD 0
> +.P
> +.PD
> +max_data_size:65536
> +.PD 0
> +.P
> +.PD
> +chunk1_size:0
> +.PD 0
> +.P
> +.PD
> +chunk2_size:1401
> +.PD 0
> +.P
> +.PD
> +rollover_cnt:0
> +.PD 0
> +.P
> +.PD
> +reset_cnt:4
> +.PP
> +\f[B]pfru \-q\f[R]
> +.PP
> +code injection image type:794bf8b2\-6e7b\-454e\-885f\-3fb9bb185402
> +.PD 0
> +.P
> +.PD
> +fw_version:0
> +.PD 0
> +.P
> +.PD
> +code_rt_version:1
> +.PD 0
> +.P
> +.PD
> +driver update image type:0e5f0b14\-f849\-7945\-ad81\-bc7b6d2bb245
> +.PD 0
> +.P
> +.PD
> +drv_rt_version:0
> +.PD 0
> +.P
> +.PD
> +drv_svn:0
> +.PD 0
> +.P
> +.PD
> +platform id:39214663\-b1a8\-4eaa\-9024\-f2bb53ea4723
> +.PD 0
> +.P
> +.PD
> +oem id:a36db54f\-ea2a\-e14e\-b7c4\-b5780e51ba3d
> +.PP
> +\f[B]pfru \-l yours.cap \-u \-T 1 \-L 4\f[R]
> +.SH AUTHORS
> +Chen Yu.
> diff --git a/tools/power/acpi/tools/pfru/Makefile b/tools/power/acpi/tools/pfru/Makefile
> new file mode 100644
> index 000000000000..09002a81e10c
> --- /dev/null
> +++ b/tools/power/acpi/tools/pfru/Makefile
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include ../../Makefile.config
> +
> +TOOL = pfru
> +EXTRA_INSTALL = install-man
> +EXTRA_UNINSTALL = uninstall-man
> +
> +CFLAGS += -Wall -O2
> +CFLAGS += -DPFRU_HEADER='"../../../../../include/uapi/linux/pfru.h"'
> +LDFLAGS += -luuid
> +
> +TOOL_OBJS = \
> +       pfru.o
> +
> +include ../../Makefile.rules
> +
> +install-man: $(srctree)/man/pfru.8
> +       $(ECHO) "  INST    " pfru.8
> +       $(QUIET) $(INSTALL_DATA) -D $< $(DESTDIR)$(mandir)/man8/pfru.8
> +uninstall-man:
> +       $(ECHO) "  UNINST  " pfru.8
> +       $(QUIET) rm -f $(DESTDIR)$(mandir)/man8/pfru.8
> diff --git a/tools/power/acpi/tools/pfru/pfru.c b/tools/power/acpi/tools/pfru/pfru.c
> new file mode 100644
> index 000000000000..eeec5043f825
> --- /dev/null
> +++ b/tools/power/acpi/tools/pfru/pfru.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform Firmware Runtime Update tool to do Management
> + * Mode code injection/driver update and telemetry retrieval.

I would be good to say a bit more here, like what interfaces are used
by this tool etc.

> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <uuid/uuid.h>
> +#include PFRU_HEADER
> +
> +char *capsule_name;
> +int action, query_cap, log_type, log_level, log_read, log_getinfo,
> +       revid, log_revid;
> +int set_log_level, set_log_type,
> +       set_revid, set_log_revid;
> +
> +char *progname;
> +
> +#define LOG_ERR                0
> +#define LOG_WARN       1
> +#define LOG_INFO       2
> +#define LOG_VERB       4
> +#define LOG_EXEC_IDX   0
> +#define LOG_HISTORY_IDX        1
> +#define REVID_1                1
> +#define REVID_2                2
> +
> +static int valid_log_level(int level)
> +{
> +       return level == LOG_ERR || level == LOG_WARN ||
> +              level == LOG_INFO || level == LOG_VERB;
> +}
> +
> +static int valid_log_type(int type)
> +{
> +       return type == LOG_EXEC_IDX || type == LOG_HISTORY_IDX;
> +}
> +
> +static inline int valid_log_revid(int id)
> +{
> +       return id == REVID_1 || id == REVID_2;
> +}
> +
> +static void help(void)
> +{
> +       fprintf(stderr,
> +               "usage: %s [OPTIONS]\n"
> +               " code injection:\n"
> +               "  -l, --load\n"
> +               "  -s, --stage\n"
> +               "  -a, --activate\n"
> +               "  -u, --update [stage and activate]\n"
> +               "  -q, --query\n"
> +               "  -d, --revid update\n"
> +               " telemetry:\n"
> +               "  -G, --getloginfo\n"
> +               "  -T, --type(0:execution, 1:history)\n"
> +               "  -L, --level(0, 1, 2, 4)\n"
> +               "  -R, --read\n"
> +               "  -D, --revid log\n",
> +               progname);
> +}
> +
> +char *option_string = "l:sauqd:GT:L:RD:h";
> +static struct option long_options[] = {
> +       {"load", required_argument, 0, 'l'},
> +       {"stage", no_argument, 0, 's'},
> +       {"activate", no_argument, 0, 'a'},
> +       {"update", no_argument, 0, 'u'},
> +       {"query", no_argument, 0, 'q'},
> +       {"getloginfo", no_argument, 0, 'G'},
> +       {"type", required_argument, 0, 'T'},
> +       {"level", required_argument, 0, 'L'},
> +       {"read", no_argument, 0, 'R'},
> +       {"setrev", required_argument, 0, 'd'},
> +       {"setrevlog", required_argument, 0, 'D'},
> +       {"help", no_argument, 0, 'h'},
> +       {}
> +};
> +
> +static void parse_options(int argc, char **argv)
> +{
> +       int option_index = 0;
> +       char *pathname;
> +       int opt;
> +
> +       pathname = strdup(argv[0]);
> +       progname = basename(pathname);
> +
> +       while ((opt = getopt_long_only(argc, argv, option_string,
> +                                      long_options, &option_index)) != -1) {
> +               switch (opt) {
> +               case 'l':
> +                       capsule_name = optarg;
> +                       break;
> +               case 's':
> +                       action = 1;
> +                       break;
> +               case 'a':
> +                       action = 2;
> +                       break;
> +               case 'u':
> +                       action = 3;
> +                       break;
> +               case 'q':
> +                       query_cap = 1;
> +                       break;
> +               case 'G':
> +                       log_getinfo = 1;
> +                       break;
> +               case 'T':
> +                       log_type = atoi(optarg);
> +                       set_log_type = 1;
> +                       break;
> +               case 'L':
> +                       log_level = atoi(optarg);
> +                       set_log_level = 1;
> +                       break;
> +               case 'R':
> +                       log_read = 1;
> +                       break;
> +               case 'd':
> +                       revid = atoi(optarg);
> +                       set_revid = 1;
> +                       break;
> +               case 'D':
> +                       log_revid = atoi(optarg);
> +                       set_log_revid = 1;
> +                       break;
> +               case 'h':
> +                       help();
> +                       exit(0);
> +               default:
> +                       break;
> +               }
> +       }
> +}
> +
> +void print_cap(struct pfru_update_cap_info *cap)
> +{
> +       char *uuid;
> +
> +       uuid = malloc(37);
> +       if (!uuid) {
> +               perror("Can not allocate uuid buffer\n");
> +               exit(1);
> +       }
> +
> +       uuid_unparse(cap->code_type, uuid);
> +       printf("code injection image type:%s\n", uuid);
> +       printf("fw_version:%d\n", cap->fw_version);
> +       printf("code_rt_version:%d\n", cap->code_rt_version);
> +
> +       uuid_unparse(cap->drv_type, uuid);
> +       printf("driver update image type:%s\n", uuid);
> +       printf("drv_rt_version:%d\n", cap->drv_rt_version);
> +       printf("drv_svn:%d\n", cap->drv_svn);
> +
> +       uuid_unparse(cap->platform_id, uuid);
> +       printf("platform id:%s\n", uuid);
> +       uuid_unparse(cap->oem_id, uuid);
> +       printf("oem id:%s\n", uuid);
> +       printf("oem information length:%d\n", cap->oem_info_len);
> +
> +       free(uuid);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int fd_update, fd_update_log, fd_capsule;
> +       struct pfru_log_data_info data_info;
> +       struct pfru_log_info info;
> +       struct pfru_update_cap_info cap;
> +       void *addr_map_capsule;
> +       struct stat st;
> +       char *log_buf;
> +       int ret = 0;
> +
> +       if (getuid() != 0) {
> +               printf("Please run the tool as root - Exiting.\n");
> +               return 1;
> +       }
> +
> +       parse_options(argc, argv);
> +
> +       fd_update = open("/dev/acpi_pfru0", O_RDWR);
> +       if (fd_update < 0) {
> +               printf("PFRU device not supported - Quit...\n");
> +               return 1;
> +       }
> +
> +       fd_update_log = open("/dev/acpi_pfru_telemetry0", O_RDWR);
> +       if (fd_update_log < 0) {
> +               printf("PFRU telemetry device not supported - Quit...\n");
> +               return 1;
> +       }
> +
> +       if (query_cap) {
> +               ret = ioctl(fd_update, PFRU_IOC_QUERY_CAP, &cap);
> +               if (ret)
> +                       perror("Query Update Capability info failed.");
> +               else
> +                       print_cap(&cap);
> +
> +               close(fd_update);
> +               close(fd_update_log);
> +
> +               return ret;
> +       }
> +
> +       if (log_getinfo) {
> +               ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_DATA_INFO, &data_info);
> +               if (ret) {
> +                       perror("Get telemetry data info failed.");
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_INFO, &info);
> +               if (ret) {
> +                       perror("Get telemetry info failed.");
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               printf("log_level:%d\n", info.log_level);
> +               printf("log_type:%d\n", info.log_type);
> +               printf("log_revid:%d\n", info.log_revid);
> +               printf("max_data_size:%d\n", data_info.max_data_size);
> +               printf("chunk1_size:%d\n", data_info.chunk1_size);
> +               printf("chunk2_size:%d\n", data_info.chunk2_size);
> +               printf("rollover_cnt:%d\n", data_info.rollover_cnt);
> +               printf("reset_cnt:%d\n", data_info.reset_cnt);
> +
> +               return 0;
> +       }
> +
> +       info.log_level = -1;
> +       info.log_type = -1;
> +       info.log_revid = -1;
> +
> +       if (set_log_level) {
> +               if (!valid_log_level(log_level)) {
> +                       printf("Invalid log level %d\n",
> +                              log_level);
> +               } else {
> +                       info.log_level = log_level;
> +               }
> +       }
> +
> +       if (set_log_type) {
> +               if (!valid_log_type(log_type)) {
> +                       printf("Invalid log type %d\n",
> +                              log_type);
> +               } else {
> +                       info.log_type = log_type;
> +               }
> +       }
> +
> +       if (set_log_revid) {
> +               if (!valid_log_revid(log_revid)) {
> +                       printf("Invalid log revid %d, unchanged.\n",
> +                              log_revid);
> +               } else {
> +                       info.log_revid = log_revid;
> +               }
> +       }
> +
> +       ret = ioctl(fd_update_log, PFRU_LOG_IOC_SET_INFO, &info);
> +       if (ret) {
> +               perror("Log information set failed.(log_level, log_type, log_revid)");
> +               close(fd_update);
> +               close(fd_update_log);
> +
> +               return 1;
> +       }
> +
> +       if (set_revid) {
> +               ret = ioctl(fd_update, PFRU_IOC_SET_REV, &revid);
> +               if (ret) {
> +                       perror("pfru update revid set failed");
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               printf("pfru update revid set to %d\n", revid);
> +       }
> +
> +       if (capsule_name) {
> +               fd_capsule = open(capsule_name, O_RDONLY);
> +               if (fd_capsule < 0) {
> +                       perror("Can not open capsule file...");
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               if (fstat(fd_capsule, &st) < 0) {
> +                       perror("Can not fstat capsule file...");
> +                       close(fd_capsule);
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               addr_map_capsule = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED,
> +                                       fd_capsule, 0);
> +               if (addr_map_capsule == MAP_FAILED) {
> +                       perror("Failed to mmap capsule file.");
> +                       close(fd_capsule);
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               ret = write(fd_update, (char *)addr_map_capsule, st.st_size);
> +               printf("Load %d bytes of capsule file into the system\n",
> +                      ret);
> +
> +               if (ret == -1) {
> +                       perror("Failed to load capsule file");
> +                       close(fd_capsule);
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               munmap(addr_map_capsule, st.st_size);
> +               close(fd_capsule);
> +               printf("Load done.\n");
> +       }
> +
> +       if (action) {
> +               if (action == 1) {
> +                       ret = ioctl(fd_update, PFRU_IOC_STAGE, NULL);
> +               } else if (action == 2) {
> +                       ret = ioctl(fd_update, PFRU_IOC_ACTIVATE, NULL);
> +               } else if (action == 3) {
> +                       ret = ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE, NULL);
> +               } else {
> +                       close(fd_update);
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +               printf("Update finished, return %d\n", ret);
> +       }
> +
> +       close(fd_update);
> +
> +       if (log_read) {
> +               void *p_mmap;
> +               int max_data_sz;
> +
> +               ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_DATA_INFO, &data_info);
> +               if (ret) {
> +                       perror("Get telemetry data info failed.");
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               max_data_sz = data_info.max_data_size;
> +               if (!max_data_sz) {
> +                       printf("No telemetry data available.\n");
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               log_buf = malloc(max_data_sz + 1);
> +               if (!log_buf) {
> +                       perror("log_buf allocate failed.");
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               p_mmap = mmap(NULL, max_data_sz, PROT_READ, MAP_SHARED, fd_update_log, 0);
> +               if (p_mmap == MAP_FAILED) {
> +                       perror("mmap error.");
> +                       close(fd_update_log);
> +
> +                       return 1;
> +               }
> +
> +               memcpy(log_buf, p_mmap, max_data_sz);
> +               log_buf[max_data_sz] = '\0';
> +               printf("%s\n", log_buf);
> +               free(log_buf);
> +
> +               munmap(p_mmap, max_data_sz);
> +       }
> +
> +       close(fd_update_log);
> +
> +       return 0;
> +}
> --

Please adjust the patch for the build fixes sent separately.

Otherwise it is fine with me.
