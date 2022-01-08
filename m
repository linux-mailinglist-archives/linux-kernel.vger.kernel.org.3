Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850A0488247
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiAHIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:20:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:51506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbiAHIUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641630047; x=1673166047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUUNUGoZ4G3LzFABmLV0lNI+D3FZ8g1pYNNsuYqZ9mk=;
  b=ZOviQIOn6qMq2ESlHXyyWfIabcMjgVH6nqUPmo2vUxtRyZcBVYmbdARz
   8t/7WLp+t/mrVBfyhaU3r7KFvdbjJwW71PBaUm2sb/z8o6Jl0RQ1ouudG
   9KbqJRvBJGXDq+VFJTV3Mpo0Qr0LIEqsHYjzPwaBLHYHNqWZrQh8w/en9
   DtcASPw7FOD2DdqFqNbXlHQlLJ6Y+0uLRAU/O9kSkNi06Ylo+5k0dlXd7
   SsLZGYSBUZD8GM6EH7gE8Zhcnxgsrl6gjwA/34kPK4auSBj0iKVoK4JB6
   b20AfypBd/YG6nWjL/zmjNnfaybYkHZR1hARn3P0WI3/Z++UQMeU0Dy0x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240546443"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="240546443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 00:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="489533921"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2022 00:20:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n66xv-0000PN-Vv; Sat, 08 Jan 2022 08:20:43 +0000
Date:   Sat, 8 Jan 2022 16:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] tracing/filter: make filter_pred_pchar() survive the
 access to user space
Message-ID: <202201081659.D34Bri2n-lkp@intel.com>
References: <20220107044951.22080-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107044951.22080-4-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.16-rc8]
[cannot apply to rostedt-trace/for-next next-20220107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/tracing-filter-make-filter_pred_pchar-survive-the-access-to-user-space/20220107-125117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: i386-randconfig-r014-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081659.D34Bri2n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/61177cfa9fa8f64bc8036d7b18c540b7b78306b0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pingfan-Liu/tracing-filter-make-filter_pred_pchar-survive-the-access-to-user-space/20220107-125117
        git checkout 61177cfa9fa8f64bc8036d7b18c540b7b78306b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/trace_events_filter.c:1346:24: error: use of undeclared identifier 'event_class_syscall_enter'
                           if (data->class == &event_class_syscall_enter)
                                               ^
   1 error generated.


vim +/event_class_syscall_enter +1346 kernel/trace/trace_events_filter.c

  1170	
  1171	/* Called when a predicate is encountered by predicate_parse() */
  1172	static int parse_pred(const char *str, struct trace_event_call *data,
  1173			      int pos, struct filter_parse_error *pe,
  1174			      struct filter_pred **pred_ptr)
  1175	{
  1176		struct trace_event_call *call = data;
  1177		struct ftrace_event_field *field;
  1178		struct filter_pred *pred = NULL;
  1179		char num_buf[24];	/* Big enough to hold an address */
  1180		char *field_name;
  1181		char q;
  1182		u64 val;
  1183		int len;
  1184		int ret;
  1185		int op;
  1186		int s;
  1187		int i = 0;
  1188	
  1189		/* First find the field to associate to */
  1190		while (isspace(str[i]))
  1191			i++;
  1192		s = i;
  1193	
  1194		while (isalnum(str[i]) || str[i] == '_')
  1195			i++;
  1196	
  1197		len = i - s;
  1198	
  1199		if (!len)
  1200			return -1;
  1201	
  1202		field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
  1203		if (!field_name)
  1204			return -ENOMEM;
  1205	
  1206		/* Make sure that the field exists */
  1207	
  1208		field = trace_find_event_field(call, field_name);
  1209		kfree(field_name);
  1210		if (!field) {
  1211			parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + i);
  1212			return -EINVAL;
  1213		}
  1214	
  1215		while (isspace(str[i]))
  1216			i++;
  1217	
  1218		/* Make sure this op is supported */
  1219		for (op = 0; ops[op]; op++) {
  1220			/* This is why '<=' must come before '<' in ops[] */
  1221			if (strncmp(str + i, ops[op], strlen(ops[op])) == 0)
  1222				break;
  1223		}
  1224	
  1225		if (!ops[op]) {
  1226			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
  1227			goto err_free;
  1228		}
  1229	
  1230		i += strlen(ops[op]);
  1231	
  1232		while (isspace(str[i]))
  1233			i++;
  1234	
  1235		s = i;
  1236	
  1237		pred = kzalloc(sizeof(*pred), GFP_KERNEL);
  1238		if (!pred)
  1239			return -ENOMEM;
  1240	
  1241		pred->field = field;
  1242		field->uaccess = 0;
  1243		pred->offset = field->offset;
  1244		pred->op = op;
  1245	
  1246		if (ftrace_event_is_function(call)) {
  1247			/*
  1248			 * Perf does things different with function events.
  1249			 * It only allows an "ip" field, and expects a string.
  1250			 * But the string does not need to be surrounded by quotes.
  1251			 * If it is a string, the assigned function as a nop,
  1252			 * (perf doesn't use it) and grab everything.
  1253			 */
  1254			if (strcmp(field->name, "ip") != 0) {
  1255				parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
  1256				goto err_free;
  1257			}
  1258			pred->fn = filter_pred_none;
  1259	
  1260			/*
  1261			 * Quotes are not required, but if they exist then we need
  1262			 * to read them till we hit a matching one.
  1263			 */
  1264			if (str[i] == '\'' || str[i] == '"')
  1265				q = str[i];
  1266			else
  1267				q = 0;
  1268	
  1269			for (i++; str[i]; i++) {
  1270				if (q && str[i] == q)
  1271					break;
  1272				if (!q && (str[i] == ')' || str[i] == '&' ||
  1273					   str[i] == '|'))
  1274					break;
  1275			}
  1276			/* Skip quotes */
  1277			if (q)
  1278				s++;
  1279			len = i - s;
  1280			if (len >= MAX_FILTER_STR_VAL) {
  1281				parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
  1282				goto err_free;
  1283			}
  1284	
  1285			pred->regex.len = len;
  1286			strncpy(pred->regex.pattern, str + s, len);
  1287			pred->regex.pattern[len] = 0;
  1288	
  1289		/* This is either a string, or an integer */
  1290		} else if (str[i] == '\'' || str[i] == '"') {
  1291			char q = str[i];
  1292	
  1293			/* Make sure the op is OK for strings */
  1294			switch (op) {
  1295			case OP_NE:
  1296				pred->not = 1;
  1297				fallthrough;
  1298			case OP_GLOB:
  1299			case OP_EQ:
  1300				break;
  1301			default:
  1302				parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
  1303				goto err_free;
  1304			}
  1305	
  1306			/* Make sure the field is OK for strings */
  1307			if (!is_string_field(field)) {
  1308				parse_error(pe, FILT_ERR_EXPECT_DIGIT, pos + i);
  1309				goto err_free;
  1310			}
  1311	
  1312			for (i++; str[i]; i++) {
  1313				if (str[i] == q)
  1314					break;
  1315			}
  1316			if (!str[i]) {
  1317				parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
  1318				goto err_free;
  1319			}
  1320	
  1321			/* Skip quotes */
  1322			s++;
  1323			len = i - s;
  1324			if (len >= MAX_FILTER_STR_VAL) {
  1325				parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
  1326				goto err_free;
  1327			}
  1328	
  1329			pred->regex.len = len;
  1330			strncpy(pred->regex.pattern, str + s, len);
  1331			pred->regex.pattern[len] = 0;
  1332	
  1333			filter_build_regex(pred);
  1334	
  1335			if (field->filter_type == FILTER_COMM) {
  1336				pred->fn = filter_pred_comm;
  1337	
  1338			} else if (field->filter_type == FILTER_STATIC_STRING) {
  1339				pred->fn = filter_pred_string;
  1340				pred->regex.field_len = field->size;
  1341	
  1342			} else if (field->filter_type == FILTER_DYN_STRING)
  1343				pred->fn = filter_pred_strloc;
  1344			else {
  1345				pred->fn = filter_pred_pchar;
> 1346				if (data->class == &event_class_syscall_enter)
  1347					pred->field->uaccess = 1;
  1348			}
  1349			/* go past the last quote */
  1350			i++;
  1351	
  1352		} else if (isdigit(str[i]) || str[i] == '-') {
  1353	
  1354			/* Make sure the field is not a string */
  1355			if (is_string_field(field)) {
  1356				parse_error(pe, FILT_ERR_EXPECT_STRING, pos + i);
  1357				goto err_free;
  1358			}
  1359	
  1360			if (op == OP_GLOB) {
  1361				parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
  1362				goto err_free;
  1363			}
  1364	
  1365			if (str[i] == '-')
  1366				i++;
  1367	
  1368			/* We allow 0xDEADBEEF */
  1369			while (isalnum(str[i]))
  1370				i++;
  1371	
  1372			len = i - s;
  1373			/* 0xfeedfacedeadbeef is 18 chars max */
  1374			if (len >= sizeof(num_buf)) {
  1375				parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
  1376				goto err_free;
  1377			}
  1378	
  1379			strncpy(num_buf, str + s, len);
  1380			num_buf[len] = 0;
  1381	
  1382			/* Make sure it is a value */
  1383			if (field->is_signed)
  1384				ret = kstrtoll(num_buf, 0, &val);
  1385			else
  1386				ret = kstrtoull(num_buf, 0, &val);
  1387			if (ret) {
  1388				parse_error(pe, FILT_ERR_ILLEGAL_INTVAL, pos + s);
  1389				goto err_free;
  1390			}
  1391	
  1392			pred->val = val;
  1393	
  1394			if (field->filter_type == FILTER_CPU)
  1395				pred->fn = filter_pred_cpu;
  1396			else {
  1397				pred->fn = select_comparison_fn(pred->op, field->size,
  1398								field->is_signed);
  1399				if (pred->op == OP_NE)
  1400					pred->not = 1;
  1401			}
  1402	
  1403		} else {
  1404			parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
  1405			goto err_free;
  1406		}
  1407	
  1408		*pred_ptr = pred;
  1409		return i;
  1410	
  1411	err_free:
  1412		kfree(pred);
  1413		return -EINVAL;
  1414	}
  1415	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
